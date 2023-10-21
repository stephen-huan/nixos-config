{ pkgs, ... }:

{
  home.packages = [ pkgs.thunderbird ];
  programs.thunderbird.enable = false;
}
