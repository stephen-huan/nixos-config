{ pkgs, ... }:

{
  home = {
    packages = [ pkgs.xlayoutdisplay ];
    file.".xlayoutdisplay" = {
      source = (pkgs.formats.keyValue { }).generate ".xlayoutdisplay" {
        # restrict frame rate to at most 60hz
        # tuxedo pulse 15 has problems with 1440p at high refresh rates
        rate = 60;
      };
    };
  };
}
