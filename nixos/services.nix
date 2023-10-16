{ lib, pkgs, ... }:

{
  services = {
    # Enable CUPS to print documents.
    # printing.enable = true;
    # Enable the OpenSSH daemon.
    # openssh.enable = true;
    locate = {
      enable = true;
      interval = "never"; # manually `updatedb`
      localuser = null;
      prunePaths = lib.mkOptionDefault [ "/persistent" ];
      package = pkgs.plocate;
    };
  };
}
