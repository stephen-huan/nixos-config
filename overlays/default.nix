{
  pkgs = final: prev: import ../pkgs/top-level { pkgs = final; };
  lib = final: prev: { lib = prev.lib // (import ../lib { pkgs = final; }); };
  bottom = import ./bottom.nix;
  caffeine-ng = import ./caffeine-ng;
  fishPlugins = import ./fishPlugins.nix;
  gcc' = import ./gcc.nix;
  gpick = import ./gpick.nix;
  mpv = import ./mpv.nix;
  nix = import ./nix.nix;
  nobinsh = import ./nobinsh.nix;
  perl' = import ./perl.nix;
  ranger = import ./ranger;
  signal-desktop = import ./signal-desktop.nix;
  sioyek = import ./sioyek.nix;
  tectonic = import ./tectonic.nix;
  texpresso = import ./texpresso.nix;
  vimPlugins = import ./vimPlugins.nix;
}
