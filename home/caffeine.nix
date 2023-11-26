{ pkgs, ... }:

{
  home.packages = [ pkgs.caffeine-ng ];
  # launched by xdg autostart
  services.caffeine.enable = false;
}
