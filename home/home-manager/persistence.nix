{ config, lib, ... }:

let
  inherit (config.home) homeDirectory;
  strip = lib.removePrefixPath homeDirectory;
  configHome = strip config.xdg.configHome;
in
{
  home.persistence.default = {
    persistentStoragePath = config._module.args.persistent;
    directories = map (directory: { inherit directory; }) (
      [
        "bin"
        ".julia"
        "micromamba"
        "not-programs"
        "programs"
        ".zotero"
        "Zotero"
      ] ++ map (name: "${configHome}/${name}") [
        "cmus"
        "home-manager"
        "libreoffice"
        "memento"
        "mozc"
        "nixpkgs"
        "Signal"
      ]
    );
    files = [
      { file = ".background-image"; method = "symlink"; }
      "${configHome}/mimeapps.list"
    ];
  };
}
