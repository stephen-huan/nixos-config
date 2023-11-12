{ pkgs, ... }:

let
  plugins = "nvim/lua/plugins";
in
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      runtime = map
        (name: {
          inherit name;
          value = { source = ./nvim/${name}; };
        }) [ "ftplugin" "lsp" "lua" "snippets" ];
    }
    {
      plugin = nvim-treesitter.withAllGrammars;
      type = "lua";
      config = builtins.readFile ./${plugins}/nvim-treesitter.lua;
    }
  ];
}
