{ pkgs, ... }:

{
  home.packages = [ pkgs.caffeine-ng ];
  # doesn't work
  services.caffeine.enable = false;
}
