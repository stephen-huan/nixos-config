{ config, pkgs, ... }:

{
  programs.firefox.enable = false;
  home.sessionVariables = { BROWSER = "firefox"; };
  home.persistence.${pkgs.lib.persistentHome config}.directories = [
    { directory = ".mozilla"; method = "symlink"; }
  ];
}
