{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.thunderbird ];
  programs.thunderbird.enable = false;
  home.persistence.${lib.persistentHome config}.directories = [
    { directory = ".thunderbird"; method = "symlink"; }
  ];
}
