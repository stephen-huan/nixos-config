# https://github.com/neovim/nvim-lspconfig/blob/master/flake.nix
{
  description = "Neovim configuration";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      systems = lib.systems.flakeExposed;
      eachDefaultSystem = f: builtins.foldl' lib.attrsets.recursiveUpdate { }
        (map f systems);
    in
    eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        formatter = pkgs.stylua;
        linters = [
          pkgs.luaPackages.luacheck
          pkgs.selene
        ];
      in
      {
        formatter.${system} = formatter;
        checks.${system}.lint = pkgs.stdenvNoCC.mkDerivation {
          name = "lint";
          src = ./.;
          doCheck = true;
          nativeCheckInputs = linters ++ pkgs.lib.singleton formatter;
          checkPhase = ''
            stylua --check .
            luacheck .
            selene .
          '';
          installPhase = "touch $out";
        };
        devShells.${system}.default = pkgs.mkShellNoCC {
          packages = [
            pkgs.lua-language-server
          ] ++ linters ++ pkgs.lib.singleton formatter;
        };
      }
    );
}
