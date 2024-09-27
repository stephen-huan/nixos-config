{ pkgs }:

let
  inherit (pkgs) callPackage;
in
{
  iwd-last-network = callPackage ../os-specific/linux/iwd-last-network { };
  simplicity-sddm-theme = callPackage ../data/themes/simplicity-sddm-theme { };
}
