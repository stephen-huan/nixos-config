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
      keyboard.bindings =
        let
          # generate unicode since toml formatter uses single quotes by default
          # https://github.com/NixOS/nixpkgs/issues/513610#issuecomment-4344168151
          ctrl-slash = builtins.fromJSON ''"\u001f"'';
          esc = builtins.fromJSON ''"\u001b"'';
        in [
        { key = "Space"; mods = "Alt"; mode = "~Search"; action = "ToggleViMode"; }
        # https://apple.stackexchange.com/q/24261
        { key = "Slash"; mods = "Control"; chars = ctrl-slash; }
        # https://stackoverflow.com/questions/16359878/how-to-map-shift-enter
        { key = "Return"; mods = "Shift"; chars = "${esc}[13;2u"; }
        { key = "Return"; mods = "Control"; chars = "${esc}[13;5u"; }
      ];
    };
  };
}
