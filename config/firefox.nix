{ config, lib, ... }:

{
  programs.firefox.enable = true;
  home.sessionVariables = lib.mkIf config.programs.firefox.enable {
    BROWSER = "firefox";
  };
  home.persistence.${lib.persistentHome config}.directories = [
    { directory = ".mozilla"; method = "symlink"; }
  ];
}
