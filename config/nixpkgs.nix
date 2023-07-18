{ lib, pkgs, ... }:

let
  unfreePkgs = map lib.getName (import ./home-manager/unfree.nix pkgs);
in
{
  nixpkgs.config = {
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) unfreePkgs;
  };
}
