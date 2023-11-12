# https://github.com/neovim/nvim-lspconfig/blob/master/flake.nix
{
  description = "Neovim configuration";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      systems = lib.systems.flakeExposed;
      eachDefaultSystem = f: builtins.foldl' lib.attrsets.recursiveUpdate { }
        (map (system: f system) systems);
    in
    eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.${system}.default = pkgs.mkShellNoCC {
          packages = [
            pkgs.lua-language-server
            pkgs.luaPackages.luacheck
            pkgs.selene
            pkgs.stylua
          ];
        };
      }
    );
}
