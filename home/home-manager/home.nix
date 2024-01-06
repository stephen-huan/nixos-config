{ pkgs, ... }:

{
  home = {
    stateVersion = "23.11";

    packages = [
      pkgs.alass
      pkgs.android-tools
      pkgs.anki
      pkgs.backintime-common
      pkgs.cmus
      pkgs.du-dust
      pkgs.ffmpeg
      pkgs.gpick
      pkgs.iw
      pkgs.jq
      pkgs.julia-bin
      pkgs.krita
      pkgs.libreoffice
      pkgs.llvmPackages_latest.libstdcxxClang
      pkgs.maim
      pkgs.memento
      pkgs.mpv
      pkgs.mupdf
      pkgs.neofetch
      pkgs.openconnect
      pkgs.pandoc
      pkgs.pulsemixer
      pkgs.python3
      pkgs.python3Packages.cython
      pkgs.python3Packages.eyeD3
      pkgs.python3Packages.pygments
      pkgs.signal-desktop
      pkgs.silver-searcher
      pkgs.texlive.combined.scheme-full
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
