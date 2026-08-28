{ lib, pkgs, osConfig, self, ... }:

let
  unfreePkgs = map lib.getName (import ./home-manager/unfree.nix pkgs);
  permittedInsecurePackages = import ./home-manager/insecure.nix pkgs;
in
{
  nixpkgs = lib.mkIf (!osConfig.home-manager.useGlobalPkgs) {
    overlays = builtins.attrValues self.overlays;
    config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) unfreePkgs;
      inherit permittedInsecurePackages;
    };
  };
}
