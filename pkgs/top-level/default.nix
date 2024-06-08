{ pkgs }:

let
  inherit (pkgs) callPackage;
in
{
  iwd-last-network = callPackage ../os-specific/linux/iwd-last-network { };
  mozcdic-ut = callPackage ../tools/inputmethods/mozcdic-ut {
    alt-cannadic = true;
    edict = true;
    neologd = true;
    skk-jisyo = true;
    sudachidict = true; # overwrite pkgs.sudachidict
  };
}
