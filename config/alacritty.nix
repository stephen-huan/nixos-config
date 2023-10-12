{
  programs.alacritty = {
    enable = true;
    settings = {
      # Font configuration
      font.size = 15.0;

      # https://github.com/alacritty/alacritty/wiki/Color-schemes
      # Colors (Tango)
      colors = {
        primary = {
          background = "#ffffff";
          foreground = "#000000";
        };
        # Normal colors
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
        # Bright colors
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
        # Cursor colors
        #
        # Colors which should be used to draw the terminal cursor.
        #
        # Allowed values are CellForeground/CellBackground; which reference the
        # affected cell; or hexadecimal colors like #ff00ff.
        cursor = {
          text = "#ffffff";
          cursor = "#000000";
        };
        # Vi mode cursor colors
        #
        # Colors for the cursor when the vi mode is active.
        #
        # Allowed values are CellForeground/CellBackground; which reference the
        # affected cell; or hexadecimal colors like #ff00ff.
        vi_mode_cursor = {
          text = "#ffffff";
          cursor = "#000000";
        };
      };
      # Bell
      #
      # The bell is rung every time the BEL control character is received.
      bell = {
        # Bell Command
        #
        # This program is executed whenever the bell is rung.
        #
        # When set to `command: None`; no command will be executed.
        command = null;
        # TODO: option to enable this
        # command = {
        #   program = "canberra-gtk-play";
        #   args = [ "-i" "bell" ];
        # };
      };
      key_bindings = [
        # Vi Mode
        { key = "Space"; mods = "Alt"; mode = "~Search"; action = "ToggleViMode"; }
        # scancode to get around invalid virtual keycode provided by winit
        # see: https://github.com/alacritty/alacritty/issues/3460
        { key = 5; mods = "Shift"; mode = "Vi|~Search"; action = "Last"; }
        { key = 7; mods = "Shift"; mode = "Vi|~Search"; action = "FirstOccupied"; }
        { key = 6; mods = "Shift"; mode = "Vi|~Search"; action = "Bracket"; }
        { key = 53; mods = "Shift"; mode = "Vi|~Search"; action = "SearchBackward"; }
        # https://stackoverflow.com/questions/16359878/how-to-map-shift-enter
        { key = "Return"; mods = "Shift"; chars = "\\x1b[13;2u"; }
        { key = "Return"; mods = "Control"; chars = "\\x1b[13;5u"; }
      ];
    };
  };
}
