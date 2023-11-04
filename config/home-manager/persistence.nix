{ config, lib, ... }:

{
  home.persistence.${lib.persistentHome config} = {
    allowOther = true;
    # uses `bindfs` (https://bindfs.org/) rather than `mount --bind`
    directories = map (directory: { inherit directory; method = "symlink"; }) [
      "bin"
      ".config/Cider"
      ".config/cmus"
      ".config/home-manager"
      ".config/memento"
      ".config/Signal"
      ".julia"
      "not-programs"
      "programs"
      ".zotero"
      "Zotero"
    ];
    files = [ ".config/mimeapps.list" ];
  };
}
