{ lib, pkgs, ... }:

let
  getConfig = name: builtins.readFile ./nvim/lua/plugins/${name}.lua;
  # see pkgs/applications/editors/vim/plugins/nvim-treesitter/overrides.nix
  # and pkgs/applications/editors/neovim/utils.nix
  collateGrammars = nvim-treesitter: nvim-treesitter.overrideAttrs {
    passthru.dependencies = [
      (pkgs.runCommandLocal "vimplugin-treesitter-grammars" { }
        ("mkdir -p $out/parser\n" + (lib.concatMapStringsSep "\n"
          (grammar:
            let name = lib.last (lib.splitString "-" grammar.name); in
            "ln -s ${grammar}/parser/${name}.so $out/parser/${name}.so"
          )
          nvim-treesitter.passthru.dependencies
        ))
      )
    ];
  };
in
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # colorscheme, fork of habamax/vim-polar
    {
      plugin = polar-nvim;
      type = "lua";
      config = getConfig "polar-nvim";
    }
    # statusline
    {
      plugin = lightline-vim;
      type = "lua";
      config = getConfig "lightline-vim";
    }
    # startup manager
    {
      plugin = vim-startify;
      type = "lua";
      config = getConfig "vim-startify";
    }
    # distraction free writing
    {
      plugin = goyo-vim;
      type = "lua";
      config = getConfig "goyo-vim";
    }
    # visualize undo tree
    {
      plugin = undotree;
      type = "lua";
      config = getConfig "undotree";
    }
    # show git in the gutter
    {
      plugin = gitsigns-nvim;
      type = "lua";
      config = getConfig "gitsigns-nvim";
    }
    # go to the last position when loading a file
    vim-lastplace
    # allow plugins to . repeat
    vim-repeat
    # ranger integration
    {
      plugin = ranger-nvim;
      type = "lua";
      config = getConfig "ranger-nvim";
    }
    # fzf
    {
      plugin = pkgs.fzf;
      type = "lua";
      config = getConfig "fzf";
    }
    # fzf + vim integration
    {
      plugin = fzf-vim;
      type = "lua";
      config = getConfig "fzf-vim";
    }
    # autocomplete
    {
      plugin = nvim-cmp;
      type = "lua";
      config = getConfig "nvim-cmp";
    }
    # autocomplete source plugins
    cmp_luasnip
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp-cmdline
    # snippets engine
    {
      plugin = luasnip;
      type = "lua";
      config = getConfig "luasnip";
    }
    # community snippets
    vim-snippets
    # detect indent and adjust indent options
    vim-sleuth
    # matching
    vim-matchup
    # insert pairs automatically
    {
      plugin = nvim-autopairs;
      type = "lua";
      config = getConfig "nvim-autopairs";
    }
    # move around easily
    {
      plugin = leap-nvim;
      type = "lua";
      config = getConfig "leap-nvim";
    }
    # tree-sitter support
    {
      # plugin = collateGrammars nvim-treesitter.withAllGrammars;
      plugin = collateGrammars (nvim-treesitter.withPlugins
        (builtins.import ./grammars.nix)
      );
      type = "lua";
      config = getConfig "nvim-treesitter";
    }
    # lsp configuration
    {
      plugin = nvim-lspconfig;
      type = "lua";
      config = getConfig "nvim-lspconfig";
    }
    # linting
    {
      plugin = nvim-lint;
      type = "lua";
      config = getConfig "nvim-lint";
    }
    # formatting
    {
      plugin = formatter-nvim;
      type = "lua";
      config = getConfig "formatter-nvim";
    }
    # LaTeX
    {
      plugin = vimtex;
      type = "lua";
      config = getConfig "vimtex";
    }
    texpresso-vim
    # cython
    vim-cython-syntax
    # julia
    julia-vim
    # lean
    {
      plugin = lean-nvim;
      type = "lua";
      config = getConfig "lean-nvim";
    }
    # markdown preview
    {
      plugin = markdown-preview-nvim;
      type = "lua";
      config = getConfig "markdown-preview-nvim";
    }
  ];
}
