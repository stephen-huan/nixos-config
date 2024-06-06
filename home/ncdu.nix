{ pkgs, ... }:

{
  home.packages = [ pkgs.ncdu ];
  # supposedly for dark backgrounds, but it works better than dark-bg
  xdg.configFile."ncdu/config".text = "--color dark";
}
