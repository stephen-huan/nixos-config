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

  outputs = { nixpkgs, home-manager, impermanence, ... }:
  let
    system = "x86_64-linux";
    hostname = "sora";
    username = "ikue";
  in {
    nixosConfigurations = {
      ${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          (import ./home.nix { path = "nixos"; })
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = import ./home.nix { path = "config"; };
              sharedModules = [ "${impermanence}/home-manager.nix" ];
              # Optionally, use extraSpecialArgs to pass arguments to home.nix
            };
          }
          impermanence.nixosModules.impermanence (import ./persistence.nix)
        ];
      };
    };
  };
}
