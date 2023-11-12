{ pkgs, ... }:

let
  getConfig = name: builtins.readFile ./nvim/lua/plugins/${name}.lua;
in
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # statusline
    {
      plugin = lightline-vim;
      type = "lua";
      config = getConfig "lightline";
    }
    # tree-sitter support
    {
      plugin = nvim-treesitter.withAllGrammars;
      type = "lua";
      config = getConfig "nvim-treesitter";
    }
  ];
}
