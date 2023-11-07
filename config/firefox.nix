{ config, lib, ... }:

{
  programs.firefox.enable = false;
  home.sessionVariables = { BROWSER = "firefox"; };
  home.persistence.${lib.persistentHome config}.directories = [
    { directory = ".mozilla"; method = "symlink"; }
  ];
}
