{
  imports = [
    ./plugins.nix
  ];
  config = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      extraLuaConfig = builtins.readFile ./nvim/init.lua;
    };
    home.sessionVariables = {
      VISUAL = "nvim";
      # use neovim to read man pages
      MANPAGER = "nvim +Man!";
      MANWIDTH = "80";
    };
  };
}
