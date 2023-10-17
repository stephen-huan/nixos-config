{ pkgs, ... }:

{
  home = {
    packages = [ pkgs.ranger ];
    file.".config/ranger" = {
      source = ./ranger;
      # ranger requires writable config directory
      recursive = true;
    };
  };
}
