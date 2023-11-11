{ pkgs, ... }:

{
  home.packages = [ pkgs.ranger ];
  xdg.configFile."ranger" = {
    source = ./ranger;
    # ranger requires writable config directory
    recursive = true;
  };
}
