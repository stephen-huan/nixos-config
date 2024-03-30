{ pkgs }:

let
  inherit (pkgs) callPackage;
in
rec {
  inflow = callPackage ../by-name/in/inflow/package.nix { inherit inflow; };
  iwd-last-network = callPackage ../os-specific/linux/iwd-last-network { };
  kanji-stroke-order-font = callPackage ../data/fonts/kanji-stroke-order-font
    { };
  mozcdic-ut = callPackage ../tools/inputmethods/mozcdic-ut {
    alt-cannadic = true;
    edict = true;
    neologd = true;
    skk-jisyo = true;
    sudachidict = true; # overwrite pkgs.sudachidict
  };
}
