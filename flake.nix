{
  description = "NixOS configuration";

  inputs = {
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
      formatter = pkgs.nixpkgs-fmt;
      linters = [ pkgs.statix ];
    in
    {
      nixosConfigurations = {
        ${hostname} = lib.nixosSystem {
          modules = [
            (lib.importDir "nixos")
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = false;
                useUserPackages = false;
                users.${username} = lib.importDir "home";
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

      formatter.${system} = formatter;

      checks.${system}.lint = pkgs.stdenvNoCC.mkDerivation {
        name = "lint";
        src = ./.;
        doCheck = true;
        nativeCheckInputs = linters ++ lib.singleton formatter;
        checkPhase = ''
          nixpkgs-fmt --check .
          statix check
        '';
        installPhase = "touch $out";
      };

      devShells.${system}.default = (pkgs.mkShellNoCC.override {
        # https://discourse.nixos.org/t/minimal-nix-shell/14373/3
        stdenv = pkgs.stdenvNoCC.override {
          initialPath = [ pkgs.coreutils ];
        };
      }) {
        packages = [
          pkgs.nil
        ] ++ linters ++ lib.singleton formatter;
      };
    };
}
