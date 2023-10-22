{
  description = "NixOS configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = { self, nixpkgs, home-manager, impermanence, ... }:
    let
      system = "x86_64-linux";
      hostname = "sora";
      username = "ikue";
      persistent = "/persistent";
      args = { inherit hostname username persistent; };
      pkgs = nixpkgs.legacyPackages.${system};
      # https://github.com/NixOS/nixpkgs/issues/156312
      # https://github.com/NixOS/nixpkgs/pull/157056
      lib = nixpkgs.lib.extend (
        final: prev: prev // (import ./lib { inherit pkgs; })
      );
    in
    {
      nixosConfigurations = {
        ${hostname} = lib.nixosSystem {
          inherit system lib;
          modules = [
            (lib.importDir "nixos")
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${username} = lib.importDir "config";
                sharedModules = [
                  "${impermanence}/home-manager.nix"
                  { _module = { inherit args; }; }
                ];
                # optionally, use extraSpecialArgs to pass arguments
                extraSpecialArgs = { inherit self; };
              };
            }
            "${impermanence}/nixos.nix"
            { _module = { inherit args; }; }
          ];
          # optionally, use specialArgs to pass arguments
          specialArgs = { inherit self; };
        };
      };
      legacyPackages.${system} = import ./. { inherit pkgs; };
      packages.${system} = lib.filterAttrs (_: v: lib.isDerivation v)
        self.legacyPackages.${system};
      inherit (self.legacyPackages.${system}) overlays;
      formatter.${system} = pkgs.nixpkgs-fmt;
      checks.${system}.lint = pkgs.stdenv.mkDerivation {
        name = "lint";
        src = ./.;
        doCheck = true;
        nativeCheckInputs = [ pkgs.statix ];
        checkPhase = "statix check --config statix.toml";
        installPhase = "touch $out";
      };
      devShells.${system}.default = pkgs.mkShell {
        packages = [ pkgs.nixpkgs-fmt pkgs.statix pkgs.nil ];
      };
    };
}
