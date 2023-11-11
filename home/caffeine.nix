{ config, lib, pkgs, ... }:

let
  configHome = lib.stripPrefix config.home.homeDirectory config.xdg.configHome;
in
{
  home.packages = [ pkgs.caffeine-ng ];
  # launched by xdg autostart
  services.caffeine.enable = false;
  home.persistence.${lib.persistentHome config}.directories = [
    { directory = "${configHome}/caffeine"; method = "symlink"; }
  ];
}
