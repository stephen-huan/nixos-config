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
    in
    {
      nixosConfigurations = {
        ${hostname} = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (import ./home.nix { path = "nixos"; })
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${username} = import ./home.nix { path = "config"; };
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
      packages.${system} = nixpkgs.lib.filterAttrs
        (_: v: nixpkgs.lib.isDerivation v)
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
