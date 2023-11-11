{
  config = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };
    xdg.configFile."nvim".source = ./nvim;
    home.sessionVariables = {
      VISUAL = "nvim";
      # use neovim to read man pages
      MANPAGER = "nvim +Man!";
      MANWIDTH = "80";
    };
  };
}
