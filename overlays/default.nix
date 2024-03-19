{
  pkgs = final: prev: import ../pkgs/top-level { pkgs = final; };
  lib = final: prev: { lib = prev.lib // (import ../lib { pkgs = final; }); };
  maintainers = import ./maintainers.nix;
  caffeine-ng = import ./caffeine-ng.nix;
  cmus = import ./cmus.nix;
  fishPlugins = import ./fishPlugins.nix;
  gcc' = import ./gcc.nix;
  ibus-engines = import ./ibus-engines.nix;
  nix = import ./nix.nix;
  nobinsh = import ./nobinsh.nix;
  perl' = import ./perl.nix;
  ranger = import ./ranger;
  sioyek = import ./sioyek.nix;
  tectonic-unwrapped = import ./tectonic-unwrapped.nix;
  vimPlugins = import ./vimPlugins.nix;
}
