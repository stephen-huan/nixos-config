{ pkgs, options, ... }:

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
      prunePaths = options.services.locate.prunePaths.default ++ [
        "/persistent"
      ];
      package = pkgs.plocate;
    };
  };
}
