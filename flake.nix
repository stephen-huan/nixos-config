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

  outputs = { nixpkgs, home-manager, impermanence, ... }: {
    nixosConfigurations = {
      sora = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          (import ./home.nix { path = "nixos"; })
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ikue = import ./home.nix { path = "config"; };
            home-manager.sharedModules = [
              "${impermanence}/home-manager.nix"
            ];
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
          impermanence.nixosModules.impermanence (import ./persistence.nix)
        ];
      };
    };
  };
}
