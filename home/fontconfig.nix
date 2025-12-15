{ pkgs, ... }:

{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
      monospace = [ "Noto Sans Mono" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
  home.packages = [
    pkgs.ipaexfont
    pkgs.ipafont
    pkgs.kanji-stroke-order-font
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji
  ];
}
