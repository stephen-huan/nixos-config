{ config, lib, pkgs, ... }:

let
  inherit (config._module.args) persistent;
in
{
  services = {
    # Enable the OpenSSH daemon.
    # openssh.enable = true;
    dbus.implementation = "broker";
    displayManager = {
      defaultSession = "none+i3";
      sddm = {
        enable = true;
        theme = "simplicity";
      };
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
      enableWifi = false;
      appConfig = {
        # see nixos/modules/services/x11/redshift.nix
        redshift = {
          isAllowed = true;
          isSystem = false;
        };
      };
    };
    printing.enable = true;
  };
  environment.systemPackages = with pkgs; [
    simplicity-sddm-theme
  ];
  systemd = lib.mkIf config.services.geoclue2.enableWifi {
    # delay until mullvad-daemon.service connects
    services = {
      geoclue.after = [ "time-sync.target" ];
      systemd-time-wait-sync.wantedBy = [ "sysinit.target" ];
    };
    # https://github.com/NixOS/nixpkgs/pull/51338
    additionalUpstreamSystemUnits = [ "systemd-time-wait-sync.service" ];
  };
  environment.etc = lib.mkIf (! config.services.geoclue2.enableWifi) {
    "geolocation".source = "${persistent}/var/lib/geolocation";
    "geoclue/conf.d/00-config.conf".text = ''
      [static-source]
      enable=true
    '';
  };
}
