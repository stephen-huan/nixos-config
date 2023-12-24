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

      pkgs.xorg.xorgserver'.out
      pkgs.xdg-utils'
    ];
    defaultPackages = lib.remove pkgs.perl
      options.environment.defaultPackages.default;
  };
  # see nixos/modules/services/x11/xserver.nix
  services.xserver = {
    displayManager = {
      xserverBin = lib.mkForce "${pkgs.xorg.xorgserver'.out}/bin/X";
      sddm.settings.X11.XephyrPath = "${pkgs.xorg.xorgserver'.out}/bin/Xephyr";
    };
    excludePackages = [
      pkgs.xorg.xorgserver.out
      pkgs.xdg-utils
    ];
  };
}
