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
    # https://wiki.archlinux.org/title/Font_configuration/Examples#CJK,_but_other_Latin_fonts_are_preferred
    configFile.noto = {
      enable = true;
      source = ./fonts.conf;
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
