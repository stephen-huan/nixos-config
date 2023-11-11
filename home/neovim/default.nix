{
  home = {
    sessionVariables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
      # use neovim to read man pages
      MANPAGER = "nvim +Man!";
      MANWIDTH = "80";
    };
  };
  xdg.configFile."nvim".source = ./nvim;
}
