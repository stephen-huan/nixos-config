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
    persistent = "/persistent";
    args = { inherit hostname username persistent; };
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
              sharedModules = [
                "${impermanence}/home-manager.nix"
                { _module = { inherit args; }; }
              ];
              # optionally, use extraSpecialArgs to pass arguments to home.nix
            };
          }
          "${impermanence}/nixos.nix"
          { _module = { inherit args; }; }
        ];
        # optionally, use specialArgs to pass arguments to configuration.nix
      };
    };
  };
}
