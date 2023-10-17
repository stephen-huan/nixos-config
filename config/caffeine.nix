{ pkgs, ... }:

{
  home.packages = [ pkgs.caffeine-ng ];
  # automatic from systemd-xdg-autostart-generator (xdg.autostart.enable)
  services.caffeine.enable = false;
}
