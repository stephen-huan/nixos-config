{
  pkgs = final: prev: import ../pkgs/top-level { pkgs = final; };
  lib = final: prev: { lib = prev.lib // (import ../lib { pkgs = final; }); };
  bottom = import ./bottom.nix;
  caffeine-ng = import ./caffeine-ng;
  fishPlugins = import ./fishPlugins.nix;
  gcc' = import ./gcc.nix;
  julia-bin = import ./julia-bin.nix;
  mpv = import ./mpv.nix;
  nix = import ./nix.nix;
  nobinsh = import ./nobinsh.nix;
  perl' = import ./perl.nix;
  ranger = import ./ranger;
  signal-desktop = import ./signal-desktop.nix;
  sioyek = import ./sioyek.nix;
  tectonic = import ./tectonic.nix;
  tectonic-unwrapped = import ./tectonic-unwrapped.nix;
  vimPlugins = import ./vimPlugins.nix;
}
