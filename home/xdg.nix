{ config, pkgs, ... }:

let
  no-op = pkgs.writeShellScript "no-op" "";
in
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
  # xdg-autostart
  systemd.user.services = {
    "app-backintime@autostart".Service.ExecStart = no-op;
    "app-picom@autostart".Service.ExecStart = no-op;
  };
  home.persistence.default.directories = map
    (path: { directory = builtins.baseNameOf path; method = "symlink"; })
    (with config.xdg.userDirs; [
      desktop
      music
      pictures
    ]);
  systemd.user.tmpfiles.rules = map (path: "d ${path}")
    (with config.xdg.userDirs; [
      download
    ]);
}
