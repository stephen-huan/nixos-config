{ config, pkgs, ... }:

{
  home.packages = [ pkgs.thunderbird ];
  programs.thunderbird.enable = false;
  home.persistence.${pkgs.lib.persistentHome config}.directories = [
    { directory = ".thunderbird"; method = "symlink"; }
  ];
}
