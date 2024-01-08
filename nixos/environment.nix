{ config, lib, pkgs, ... }:

let
  inherit (config._module.args) username hostname;
  inherit (config.users.users.${username}) home;
  machine-id = builtins.substring 0 32 (builtins.hashString "sha256" hostname);
in
{
  environment = {
    systemPackages = with pkgs; [
      # required for flakes
      git
    ];
    etc = {
      "nixos/flake.nix".source = "${home}/.config/home-manager/flake.nix";
      "machine-id".text = "${machine-id}\n";
    };
    # prevent creation of /lib and /lib64
    stub-ld.enable = false;
    # hidden option. see: nixos/modules/config/shells-environment.nix
    # follow nixpkgs's default sandbox shell (which shouldn't pull in deps)
    # see https://github.com/NixOS/nix/blob/master/flake.nix
    binsh = pkgs.writeShellScript "busybox-wrapper" ''
      echo "$(${pkgs.coreutils}/bin/date --rfc-3339=seconds)\
       $PPID $(${lib.getExe pkgs.ps} --pid $PPID -o command=)"\
       >> "$HOME/violators"
      ${pkgs.busybox-sandbox-shell}/bin/sh "$@"
    '';
    # hidden option. see: nixos/modules/system/activation/activation-script.nix
    # remove /usr/bin/env for reproducibility or purity or whatever
    usrbinenv = null;
  };
  system.activationScripts = {
    binsh = lib.mkIf true (lib.mkForce ''
      rm -f /bin/sh
      if test -e /bin; then
        rmdir --ignore-fail-on-non-empty /bin
      fi
    '');
    # https://github.com/NixOS/nixpkgs/issues/260658
    usrbinenv = lib.mkIf (config.environment.usrbinenv == null) (lib.mkForce ''
      rm -f /usr/bin/env
      if test -e /usr/bin; then
        rmdir --ignore-fail-on-non-empty /usr/bin
      fi
      if test -e /usr; then
        rmdir --ignore-fail-on-non-empty /usr
      fi
    '');
  };
  systemd.services.systemd-update-done.serviceConfig.ExecStart = [
    # clear
    ""
    (
      pkgs.writeShellScript "systemd-update-done-wrapper" ''
        mkdir -p /usr
        /run/current-system/sw/lib/systemd/systemd-update-done
        rmdir --ignore-fail-on-non-empty /usr
      ''
    )
  ];
}
