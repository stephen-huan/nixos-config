{ pkgs, ... }:

let
  plugins = "nvim/lua/plugins";
in
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-treesitter.withAllGrammars;
      type = "lua";
      config = builtins.readFile ./${plugins}/nvim-treesitter.lua;
    }
  ];
}
