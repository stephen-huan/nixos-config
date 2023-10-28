{
  home = {
    file.".config/nvim".source = ./nvim;
    sessionVariables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
      # use neovim to read man pages
      MANPAGER = "nvim +Man!";
      MANWIDTH = "80";
    };
  };
}
