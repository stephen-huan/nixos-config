{ pkgs, ... }:

{
  home.packages = [
      pkgs.gawk'
      pkgs.gnugrep'
      pkgs.perl'
  ];
}
