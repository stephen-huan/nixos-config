{ pkgs }:

let
  inherit (pkgs) callPackage;
in
{
  iwd-last-network = callPackage ../os-specific/linux/iwd-last-network { };
}
