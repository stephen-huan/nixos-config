{
  programs.firefox.enable = false;
  home.sessionVariables = { BROWSER = "firefox"; };
  home.persistence.default.directories = [
    { directory = ".mozilla"; method = "symlink"; }
  ];
}
