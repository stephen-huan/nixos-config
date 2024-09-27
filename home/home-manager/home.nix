{ pkgs, ... }:

{
  home = {
    stateVersion = "23.11";

    packages = [
      pkgs.alass
      pkgs.android-tools
      pkgs.anki
      pkgs.cmus
      pkgs.comma
      pkgs.diffoscopeMinimal
      pkgs.du-dust
      pkgs.ffmpeg-full
      pkgs.gpick
      pkgs.iw
      pkgs.jq
      pkgs.julia-bin
      pkgs.krita
      pkgs.lean4
      pkgs.libreoffice
      pkgs.maim
      pkgs.memento
      pkgs.mpv
      pkgs.mupdf
      pkgs.neofetch
      pkgs.openconnect
      pkgs.pandoc
      pkgs.pulsemixer
      pkgs.python3
      pkgs.python3Packages.pygments
      pkgs.python3Packages.pytaglib
      pkgs.signal-desktop
      pkgs.silver-searcher
      pkgs.tectonic
      pkgs.tokei
      pkgs.trashy
      pkgs.tree
      pkgs.unzip
      pkgs.xclip
      pkgs.yacreader
      pkgs.yubikey-manager
      pkgs.zathura
      pkgs.zbar
      pkgs.zip
      pkgs.zotero
    ] ++ (import ./unfree.nix pkgs);

    sessionVariables = {
      # restrict openMP from using all CPU resources (monitor flickering)
      OMP_NUM_THREADS = "4";
    };
  };
}
