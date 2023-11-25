{
  # https://docs.gtk.org/glib/gvariant-format-strings.html
  dconf.settings = {
    "desktop/ibus/general" = rec {
      engines-order = [ "xkb:us::eng" "mozc-jp" ];
      preload-engines = engines-order;
      use-system-keyboard-layout = true;
    };
    "desktop/ibus/general/hotkey" = {
      triggers = [ "<Control>space" ];
    };
  };
}
