{ pkgs, ... }:

{
  i18n = {
    # Select internationalisation properties.
    # defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ mozc-ut ];
    };
  };
}
