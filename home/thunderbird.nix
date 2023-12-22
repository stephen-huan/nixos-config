{ pkgs, ... }:

{
  home.packages = [ pkgs.thunderbird ];
  programs.thunderbird.enable = false;
  home.persistence.default.directories = [
    { directory = ".thunderbird"; method = "symlink"; }
  ];
}
