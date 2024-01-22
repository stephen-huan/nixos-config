{
  programs.alacritty = {
    enable = true;
    settings = {
      font.size = 15.0;
      # https://github.com/alacritty/alacritty/wiki/Color-schemes
      # Colors (Tango)
      colors = {
        primary = {
          background = "#ffffff";
          foreground = "#000000";
        };
        normal = {
          black = "#2e3436";
          red = "#cc0000";
          green = "#73d216";
          yellow = "#edd400";
          blue = "#3465a4";
          magenta = "#75507b";
          cyan = "#06989a";
          white = "#d3d7cf";
        };
        bright = {
          black = "#2e3436";
          red = "#ef2929";
          green = "#8ae234";
          yellow = "#fce94f";
          blue = "#729fcf";
          magenta = "#ad7fa8";
          cyan = "#34e2e2";
          white = "#eeeeec";
        };
        cursor = {
          text = "#ffffff";
          cursor = "#000000";
        };
        vi_mode_cursor = {
          text = "#ffffff";
          cursor = "#000000";
        };
      };
      bell = {
        # TODO: option to enable this
        # command = {
        #   program = "canberra-gtk-play";
        #   args = [ "-i" "bell" ];
        # };
      };
      keyboard.bindings = [
        { key = "Space"; mods = "Alt"; mode = "~Search"; action = "ToggleViMode"; }
        # https://stackoverflow.com/questions/16359878/how-to-map-shift-enter
        { key = "Return"; mods = "Shift"; chars = "\\u001b[13;2u"; }
        { key = "Return"; mods = "Control"; chars = "\\u001b[13;5u"; }
      ];
    };
  };
}
