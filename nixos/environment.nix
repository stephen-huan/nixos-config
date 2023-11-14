{ config, lib, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      git # required for flakes
      backintime
    ];
    # hidden option. see: nixos/modules/config/shells-environment.nix
    # follow nixpkgs's default sandbox shell (which shouldn't pull in deps)
    # see https://github.com/NixOS/nix/blob/master/flake.nix
    binsh = "${pkgs.busybox-sandbox-shell}/bin/busybox";
    # hidden option. see: nixos/modules/system/activation/activation-script.nix
    # remove /usr/bin/env for reproducibility or purity or whatever
    usrbinenv = null;
  };
  # https://github.com/NixOS/nixpkgs/issues/260658
  system.activationScripts.usrbinenv =
    lib.mkIf (config.environment.usrbinenv == null) (
      lib.mkForce ''
        rm -f /usr/bin/env
        if test -e /usr/bin; then
          rmdir --ignore-fail-on-non-empty /usr/bin
        fi
        if test -e /usr; then
          rmdir --ignore-fail-on-non-empty /usr
        fi
      ''
    );
  systemd.services.systemd-update-done.serviceConfig.ExecStart = [
    "" # clear
    (
      pkgs.writeShellScript "systemd-update-done-wrapper" ''
        mkdir -p /usr
        /run/current-system/sw/lib/systemd/systemd-update-done
        rmdir --ignore-fail-on-non-empty /usr
      ''
    )
  ];
}
