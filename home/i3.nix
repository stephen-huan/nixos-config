{ config, lib, options, ... }:

let
  cfg = config.xsession.windowManager.i3;
  i3options = (builtins.elemAt (builtins.elemAt
    options.xsession.windowManager.i3.config.type.getSubModules 0
  ).imports 0).options;
  replaceKeys = [
    { old = cfg.config.modifier; new = "$mod"; }
  ] ++ map (old: { inherit old; new = "\$${lib.toLower old}"; })
    [ "Shift" "Left" "Down" "Up" "Right" ];
  replaceBindings = map
    (old: { old = "number ${old}"; new = "number \$ws${old}"; })
    (map builtins.toString (lib.range 1 10));
  replace = rules: s: builtins.replaceStrings
    (map (builtins.getAttr "old") rules)
    (map (builtins.getAttr "new") rules)
    s;
  keybindings = (lib.mapAttrs'
    (name: value: {
      name = replace replaceKeys name;
      value = replace replaceBindings value.content;
    })
    (lib.filterAttrs
      (name: _: ! builtins.elem name [
        # conflicts with $mod+$left
        "${cfg.config.modifier}+h"
        # remove layout tabbed
        "${cfg.config.modifier}+w"
      ])
      i3options.keybindings.default
    )
  ) // {
    "$mod+semicolon" = "split h";
    # override layout stacking
    "$mod+s" = "focus child";
    # relative movement
    "$mod+z" = "workspace back_and_forth";
    "$mod+bracketleft" = "workspace prev";
    "$mod+bracketright" = "workspace next";
    "$mod+$shift+z" = "move container to workspace back_and_forth";
    "$mod+$shift+bracketleft" = "move container to workspace prev";
    "$mod+$shift+bracketright" = "move container to workspace next";
    # use wpctl to adjust volume in pipewire
    "XF86AudioRaiseVolume" =
      "${exec} wpctl set-volume @DEFAULT_SINK@   5%+    && ${refresh_status}";
    "XF86AudioLowerVolume" =
      "${exec} wpctl set-volume @DEFAULT_SINK@   5%-    && ${refresh_status}";
    "XF86AudioMute" =
      "${exec} wpctl set-mute   @DEFAULT_SINK@   toggle && ${refresh_status}";
    "XF86AudioMicMute" =
      "${exec} wpctl set-mute   @DEFAULT_SOURCE@ toggle && ${refresh_status}";
    # use playerctl and the MPRIS protocol to control media players
    # headphones alternate between play/pause while keyboard just has play
    # so to keep it consistent, force both to toggle
    "XF86AudioPlay   " = "${exec} playerctl play-pause";
    "XF86AudioPause  " = "${exec} playerctl play-pause";
    "XF86AudioStop   " = "${exec} playerctl stop";
    "XF86AudioPrev   " = "${exec} playerctl previous";
    "XF86AudioNext   " = "${exec} playerctl next";
    "XF86AudioForward" = "${exec} playerctl position 1+";
    "XF86AudioRewind " = "${exec} playerctl position 1-";
    # screenshot (see https://github.com/naelstrof/maim#examples)
    "Control+Shift+3" = "${exec} ${screenshot}        | ${copy_image}";
    "Control+Shift+4" = "${exec} ${screenshot_select} | ${copy_image}";
    "Mod4+Shift+3   " = "${exec} ${screenshot}          ${image_path}";
    "Mod4+Shift+4   " = "${exec} ${screenshot_select}   ${image_path}";
    # ames (see https://github.com/eshrh/ames)
    "$mod+n    " = "${exec} ames -c";
    "$mod+m    " = "${exec} ames -r";
    "$mod+comma" = "${exec} ames -w";
  };
  exec = "exec --no-startup-id";
  refresh_status = "killall -SIGUSR1 i3status";
  screenshot = "maim --hidecursor";
  screenshot_select = "maim --hidecursor --select --nodrag";
  copy_image = "xclip -selection clipboard -target image/png";
  image_path = "~/Pictures/screenshot-$(date +%s).png";
in
{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      window = {
        titlebar = false;
        border = 4;
      };
      gaps = {
        inner = 10;
        outer = 10;
        smartGaps = true;
        smartBorders = "on";
      };
      # --no-startup-id because alacritty does not send the proper response
      # https://github.com/alacritty/alacritty/issues/868
      terminal = "--no-startup-id alacritty";
      menu = "--no-startup-id dmenu_run";
      bars = [{ statusCommand = "i3status"; position = "top"; }];
      floating.modifier = "$mod";
      modes = {
        resize = {
          "$left" = "resize shrink width 10 px or 10 ppt";
          "$down" = "resize grow height 10 px or 10 ppt";
          "$up" = "resize shrink height 10 px or 10 ppt";
          "$right" = "resize grow width 10 px or 10 ppt";
          "Return" = "mode default";
          "Escape" = "mode default";
          "$mod+r" = "mode default";
        };
      };
      inherit keybindings;
    };
    extraConfig = ''
      # modifiers
      set $mod Shift+Mod1+Mod4
      set $shift Control
      # directions
      set $left h
      set $down j
      set $up k
      set $right l
      # workspaces
      set $ws1 "1"
      set $ws2 "2"
      set $ws3 "3"
      set $ws4 "4"
      set $ws5 "5"
      set $ws6 "6"
      set $ws7 "7"
      set $ws8 "8"
      set $ws9 "9"
      set $ws10 "10"
    '';
  };
}
