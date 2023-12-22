{ config, pkgs, ... }:

let
  strip = pkgs.lib.stripPrefix config.home.homeDirectory;
  configHome = strip config.xdg.configHome;
in
{
  home.persistence.${pkgs.lib.persistentHome config} = {
    allowOther = true;
    # uses `bindfs` (https://bindfs.org/) rather than `mount --bind`
    directories = map (directory: { inherit directory; method = "symlink"; }) (
      [
        "bin"
        ".julia"
        "micromamba"
        "not-programs"
        ".password-store"
        "programs"
        ".zotero"
        "Zotero"
      ] ++ map (name: "${configHome}/${name}") [
        "cmus"
        "home-manager"
        "memento"
        "mozc"
        "Signal"
      ]
    );
    files = [
      ".background-image"
      "${configHome}/mimeapps.list"
    ];
  };
}
