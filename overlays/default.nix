{
  pkgs = final: prev: import ../pkgs/top-level { pkgs = final; };
  lib = final: prev: { lib = prev.lib // (import ../lib { pkgs = final; }); };
  caffeine-ng = import ./caffeine-ng;
  fish = import ./fish.nix;
  fishPlugins = import ./fishPlugins.nix;
  gcc' = import ./gcc.nix;
  mpv = import ./mpv.nix;
  nix = import ./nix.nix;
  nobinsh = import ./nobinsh.nix;
  perl' = import ./perl.nix;
  ranger = import ./ranger;
  signal-desktop = import ./signal-desktop.nix;
  tectonic = import ./tectonic.nix;
  texpresso = import ./texpresso.nix;
  vimPlugins = import ./vimPlugins.nix;
  xlayoutdisplay = import ./xlayoutdisplay.nix;
}
