{ lib, config, ... }:

{
  programs.firefox.enable = true;
  home.sessionVariables = lib.mkIf config.programs.firefox.enable {
    BROWSER = "firefox";
  };
}
