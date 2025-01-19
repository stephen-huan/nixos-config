{ config, lib, pkgs, ... }:

let
  inherit (config._module.args) username hostname;
  inherit (config.users.users.${username}) home;
  machine-id = builtins.substring 0 32 (builtins.hashString "sha256" hostname);
  usr-services = [
    "dbus-broker.service"
    "systemd-update-done.service"
    "logrotate.service"
    "fwupd.service"
    "fwupd-refresh.service"
  ];
  usr-service = {
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    wantedBy = usr-services;
  };
  usr-service-reload = lib.attrsets.recursiveUpdate usr-service {
    unitConfig.ReloadPropagatedFrom = usr-services;
    serviceConfig.RemainAfterExit = "yes";
    script = " "; # no-op
    wantedBy = [ ];
    upheldBy = usr-services;
  };
in
{
  environment = {
    systemPackages = with pkgs; [
      git # required for flakes
      backintime-common
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
  };
  systemd.services = rec {
    mkdir-usr = usr-service // {
      script = "mkdir -p /usr";
      before = usr-services;
    };
    mkdir-usr-reload = usr-service-reload // {
      reload = mkdir-usr.script;
      before = usr-services;
    };
    rmdir-usr = usr-service // {
      script = "rmdir --ignore-fail-on-non-empty /usr";
      after = usr-services;
    };
    rmdir-usr-reload = usr-service-reload // {
      reload = rmdir-usr.script;
      after = usr-services;
    };
  };
}
