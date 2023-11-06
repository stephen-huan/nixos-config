{ config, lib, ... }:

let
  strip = lib.stripPrefix config.home.homeDirectory;
  configHome = strip config.xdg.configHome;
in
{
  home.persistence.${lib.persistentHome config} = {
    allowOther = true;
    # uses `bindfs` (https://bindfs.org/) rather than `mount --bind`
    directories = map (directory: { inherit directory; method = "symlink"; }) [
      "bin"
      ".julia"
      "not-programs"
      ".password-store"
      "programs"
      ".zotero"
      "Zotero"
    ] ++ map
      (name: { directory = "${configHome}/${name}"; method = "symlink"; }) [
      "Cider"
      "cmus"
      "home-manager"
      "memento"
      "Signal"
    ];
    files = [ "${configHome}/mimeapps.list" ];
  };
}
