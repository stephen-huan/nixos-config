{ config, lib, pkgs, ... }:

{
  services = {
    # Enable CUPS to print documents.
    # printing.enable = true;
    # Enable the OpenSSH daemon.
    # openssh.enable = true;
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
}
