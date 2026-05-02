{ pkgs, ... }:

{
  programs.neovim.extraPackages = [
    pkgs.black
    pkgs.clang-tools
    pkgs.inflow
    pkgs.isort
    pkgs.lua-language-server
    pkgs.luaPackages.luacheck
    pkgs.nil
    pkgs.nixpkgs-fmt
    pkgs.bash-language-server
    pkgs.prettier
    pkgs.vscode-langservers-extracted
    pkgs.pyright
    pkgs.python3
    pkgs.ripgrep
    pkgs.ruff
    pkgs.selene
    pkgs.shellcheck
    pkgs.shfmt
    pkgs.statix
    pkgs.stylua
    pkgs.taplo
    pkgs.tectonic
    pkgs.texlab
    pkgs.texpresso
    pkgs.tree-sitter
    pkgs.yaml-language-server
  ];
}
