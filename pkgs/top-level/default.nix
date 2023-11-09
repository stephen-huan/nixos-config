{ pkgs }:

let
  inherit (pkgs) callPackage;
in
{
  iwd-last-network = callPackage ../os-specific/linux/iwd-last-network { };
  mozcdic-ut = callPackage ../tools/inputmethods/mozcdic-ut { };
  kanjistrokeorders = callPackage ../data/fonts/kanjistrokeorders { };
}
