{ pkgs, ... }:

{
  home.packages = [ pkgs.ncdu ];
  xdg.configFile = {
    "ncdu/config".text = ''
      # supposedly for dark backgrounds, but it works better than dark-bg
      --color dark
    '';
  };
}
