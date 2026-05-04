{ config, lib, pkgs, options, ... }:

let
  cfg = config.boot.initrd.systemd;
  usrbinenv =
    if config.environment.usrbinenv != null
    then config.environment.usrbinenv
    else options.environment.usrbinenv.default;
  script = pkgs.writeShellScript "usrbinenv" ''
    export PATH="${pkgs.coreutils}/bin"

    mkdir -p /usr/bin
    chmod 0755 /usr/bin
    ln -sfn ${usrbinenv} /usr/bin/.env.tmp
    mv /usr/bin/.env.tmp /usr/bin/env # atomically replace /usr/bin/env
  '';
in
{
  boot = {
    kernelParams = [ "boot.shell_on_fail" ];
    loader = {
      efi.canTouchEfiVariables = false;
      systemd-boot = {
        enable = true;
        editor = false;
      };
    };
    # work around systemd initrd not supporting no /usr
    # - https://github.com/NixOS/nixpkgs/pull/435781
    # - https://systemd.io/INITRD_INTERFACE/
    # - https://systemd.io/SEPARATE_USR_IS_BROKEN/
    initrd.systemd.services = {
      initrd-nixos-activation-post = {
        after = [ "initrd-nixos-activation.service" ];
        requiredBy = [ "initrd-switch-root.service" ];
        before = [ "initrd-switch-root.service" ];
        unitConfig.DefaultDependencies = false;
        serviceConfig.Type = "oneshot";

        # see nixos/modules/system/boot/systemd/initrd.nix
        script = ''
          set -uo pipefail
          export PATH="/bin:${cfg.package.util-linux}/bin"
          exec chroot /sysroot "${script}"
        '';
      };
    };
  };
  systemd.services.initrd-nixos-activation-post-post = {
    wantedBy = [ "local-fs-pre.target" ];
    before = [ "local-fs-pre.target" ];
    unitConfig.DefaultDependencies = false;
    serviceConfig.Type = "oneshot";

    script = ''
      if test -L /bin; then rm -f /bin; fi

      rm -f /usr/bin/env
      if test -d /usr/bin; then rmdir --ignore-fail-on-non-empty /usr/bin; fi
      if test -d /usr; then rmdir --ignore-fail-on-non-empty /usr; fi
    '';
  };
}
