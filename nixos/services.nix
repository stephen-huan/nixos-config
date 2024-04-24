{ config, lib, pkgs, ... }:

{
  services = {
    # Enable CUPS to print documents.
    # printing.enable = true;
    # Enable the OpenSSH daemon.
    # openssh.enable = true;
    displayManager = {
      defaultSession = "none+i3";
      sddm.enable = true;
      autoLogin = {
        enable = true;
        user = config._module.args.username;
      };
    };
    pipewire = {
      enable = true;
      wireplumber.enable = true;
      audio.enable = true;
      pulse.enable = true;
    };
    locate = {
      enable = true;
      interval = "never"; # manually `updatedb`
      localuser = null;
      prunePaths = lib.mkOptionDefault [ "${config._module.args.persistent}" ];
      package = pkgs.plocate;
    };
    geoclue2 = {
      enable = true;
      appConfig = {
        # see nixos/modules/services/x11/redshift.nix
        redshift = {
          isAllowed = true;
          isSystem = false;
        };
      };
    };
  };
  systemd = {
    # delay until mullvad-daemon.service connects
    services.geoclue.after = [ "time-sync.target" ];
    # https://github.com/NixOS/nixpkgs/pull/51338
    additionalUpstreamSystemUnits = [ "systemd-time-wait-sync.service" ];
    services.systemd-time-wait-sync.wantedBy = [ "sysinit.target" ];
  };
}
