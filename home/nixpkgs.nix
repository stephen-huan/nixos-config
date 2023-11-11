{ lib, pkgs, self, ... }:

let
  unfreePkgs = map lib.getName (import ./home-manager/unfree.nix pkgs);
  permittedInsecurePackages = import ./home-manager/insecure.nix pkgs;
in
{
  nixpkgs = {
    overlays = builtins.attrValues self.overlays;
    config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) unfreePkgs;
      inherit permittedInsecurePackages;
    };
  };
}
