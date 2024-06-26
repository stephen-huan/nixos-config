let
  neovimFiles = map
    (name: {
      name = "nvim/${name}";
      value = { source = ./nvim/${name}; };
    }) [
    "after"
    "lsp"
    "lua"
    "snippets"
  ];
in
{
  imports = [
    ./packages.nix
    ./plugins.nix
  ];
  config = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      extraLuaConfig = builtins.readFile ./nvim/init.lua;
    };
    xdg.configFile = builtins.listToAttrs neovimFiles;
    home.sessionVariables = {
      VISUAL = "nvim";
      # use neovim to read man pages
      MANPAGER = "nvim +Man!";
      MANWIDTH = "80";
    };
  };
}
