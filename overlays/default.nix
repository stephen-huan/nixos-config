{
  pkgs = final: prev: import ../pkgs/top-level { pkgs = final; };
  lib = final: prev: { lib = prev.lib // (import ../lib { pkgs = final; }); };
  maintainers = import ./maintainers.nix;
  backintime = import ./backintime.nix;
  fishPlugins = import ./fishPlugins.nix;
  ibus-engines = import ./ibus-engines.nix;
  vimPlugins = import ./vimPlugins.nix;
}
