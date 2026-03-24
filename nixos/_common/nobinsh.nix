{ lib, pkgs, options, ... }:

{
  # strictly speaking, unnecessary
  nix.package = pkgs.nix';
  # see nixos/modules/config/system-path.nix
  environment = {
    systemPackages = [
      # packages in requiredPackages can't be removed
      pkgs.gawk'
      pkgs.gcc'.libc
      pkgs.gnugrep'

      pkgs.perl'

      pkgs.xorg-server'.out
      pkgs.xdg-utils'
    ];
    defaultPackages = lib.remove pkgs.perl
      options.environment.defaultPackages.default;
  };
  services.displayManager.sddm.settings = {
    X11.XephyrPath = "${pkgs.xorg-server'.out}/bin/Xephyr";
  };
  # see nixos/modules/services/x11/xserver.nix
  services.xserver = {
    displayManager = {
      xserverBin = lib.mkForce "${pkgs.xorg-server'.out}/bin/X";
    };
    excludePackages = [
      pkgs.xorg-server.out
      pkgs.xdg-utils
    ];
  };
}
