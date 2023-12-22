{ config, pkgs, ... }:

let
  inherit (config.home) homeDirectory;
  persistentStoragePath = "${config._module.args.persistent}${homeDirectory}";
  strip = pkgs.lib.stripPrefix homeDirectory;
  configHome = strip config.xdg.configHome;
in
{
  home.persistence.default = {
    inherit persistentStoragePath;
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
