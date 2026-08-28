{ pkgs }:

(import ./pkgs/top-level { inherit pkgs; }) // (import ./modules) // {
  lib = import ./lib { inherit pkgs; };
  overlays = import ./overlays;
}
