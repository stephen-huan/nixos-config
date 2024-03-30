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
    pkgs.nodePackages.bash-language-server
    pkgs.nodePackages.jsonlint
    pkgs.nodePackages.prettier
    pkgs.nodePackages.pyright
    pkgs.nodePackages.vscode-langservers-extracted
    pkgs.ruff
    pkgs.selene
    pkgs.shellcheck
    pkgs.shfmt
    pkgs.statix
    pkgs.stylua
    pkgs.taplo
    pkgs.texlab
  ];
}
