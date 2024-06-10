{ pkgs, ... }:

let
  getConfig = name: builtins.readFile ./nvim/lua/plugins/${name}.lua;
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
    bclose-vim
    {
      plugin = ranger-vim;
      type = "lua";
      config = getConfig "ranger-vim";
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
      # plugin = nvim-treesitter.withAllGrammars;
      plugin = nvim-treesitter.withPlugins (p: with p; [
        asm
        awk
        bibtex
        cmake
        comment
        cpp
        css
        csv
        cuda
        diff
        disassembly
        fish
        fortran
        gitattributes
        gitcommit
        git_config
        gitignore
        git_rebase
        gpg
        haskell
        hlsplaylist
        html
        http
        ini
        java
        javascript
        jq
        jsdoc
        json
        julia
        latex
        liquid
        make
        meson
        mlir
        muttrc
        nix
        passwd
        pem
        perl
        printf
        pymanifest
        qmljs
        r
        regex
        requirements
        rst
        ruby
        rust
        sql
        ssh_config
        toml
        udev
        xml
        yaml
        zathurarc
      ]);
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
