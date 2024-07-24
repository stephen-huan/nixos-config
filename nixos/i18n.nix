{ lib, pkgs, ... }:

{
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = lib.mkOptionDefault [ "ja_JP.UTF-8/UTF-8" ];
    inputMethod = {
      enable = true;
      type = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ mozc-ut ];
    };
  };
}
