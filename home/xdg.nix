{ config, pkgs, ... }:

{
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps.enable = false;
    userDirs = {
      enable = true;
      createDirectories = false;
    };
  };
  home.persistence.${pkgs.lib.persistentHome config}.directories = map
    (path: { directory = builtins.baseNameOf path; method = "symlink"; })
    (with config.xdg.userDirs; [
      desktop
      music
      pictures
    ]);
}
