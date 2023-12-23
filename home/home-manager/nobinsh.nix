{ pkgs, ... }:

{
  home.packages = [
      pkgs.gawk'
      pkgs.gnugrep'
      pkgs.nix' # strictly speaking, unnecessary
      pkgs.perl'
      pkgs.xdg-utils'
  ];
}
