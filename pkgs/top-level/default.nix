{ pkgs }:

{
  iwd-last-network = pkgs.callPackage
    ../os-specific/linux/iwd-last-network { };
}
