{ pkgs }:

let
  inherit (pkgs) callPackage;
in
{
  iwd-last-network = callPackage ../os-specific/linux/iwd-last-network { };
  kanjistrokeorders = callPackage ../data/fonts/kanjistrokeorders { };
  mozcdic-ut = callPackage ../tools/inputmethods/mozcdic-ut {
    alt-cannadic = true;
    edict = true;
    skk-jisyo = true;
    sudachidict = true;
  };
}
