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

      pkgs.xdg-utils'
    ];
    defaultPackages = lib.remove pkgs.perl
      options.environment.defaultPackages.default;
  };
}
