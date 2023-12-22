{
  pkgs = final: prev: import ../pkgs/top-level { pkgs = final; };
  lib = final: prev: { lib = prev.lib // (import ../lib { pkgs = final; }); };
  maintainers = import ./maintainers.nix;
  caffeine-ng = import ./caffeine-ng.nix;
  fishPlugins = import ./fishPlugins.nix;
  gcc' = import ./gcc.nix;
  i3 = import ./i3.nix;
  ibus-engines = import ./ibus-engines.nix;
  perl' = import ./perl.nix;
  ranger = import ./ranger;
  vimPlugins = import ./vimPlugins.nix;
}
