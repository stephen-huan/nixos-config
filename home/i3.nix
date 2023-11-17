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
      bars = [{ statusCommand = "i3status"; position = "top"; }];
      keybindings = { }; # TODO: patch existing keybinds
    };
    extraConfig = ''
      set $mod shift+mod1+mod4
      set $sup control

      # Use pactl to adjust volume in PulseAudio.
      set $refresh_i3status killall -SIGUSR1 i3status
      bindsym XF86AudioRaiseVolume exec --no-startup-id wpctl set-volume @DEFAULT_SINK@   5%+    && $refresh_i3status
      bindsym XF86AudioLowerVolume exec --no-startup-id wpctl set-volume @DEFAULT_SINK@   5%-    && $refresh_i3status
      bindsym XF86AudioMute        exec --no-startup-id wpctl set-mute   @DEFAULT_SINK@   toggle && $refresh_i3status
      bindsym XF86AudioMicMute     exec --no-startup-id wpctl set-mute   @DEFAULT_SOURCE@ toggle && $refresh_i3status

      # use playerctl and the MPRIS protocol to control media players
      # see: https://wiki.archlinux.org/title/MPRIS
      # https://specifications.freedesktop.org/mpris-spec/latest/
      # https://github.com/altdesktop/playerctl

      # my headphones alternate between play/pause while my keyboard just has play
      # so to keep it consistent, force both to toggle
      bindsym XF86AudioPlay    exec --no-startup-id playerctl play-pause
      bindsym XF86AudioPause   exec --no-startup-id playerctl play-pause
      bindsym XF86AudioStop    exec --no-startup-id playerctl stop
      bindsym XF86AudioPrev    exec --no-startup-id playerctl previous
      bindsym XF86AudioNext    exec --no-startup-id playerctl next
      bindsym XF86AudioForward exec --no-startup-id playerctl position 1+
      bindsym XF86AudioRewind  exec --no-startup-id playerctl position 1-

      # screenshot: https://github.com/naelstrof/maim#examples
      set $screenshot        maim --hidecursor
      set $screenshot_select maim --hidecursor --select --nodrag
      set $copy_image xclip -selection clipboard -target image/png
      set $image_path ~/Pictures/screenshot-$(date +%s).png
      bindsym control+shift+3 exec --no-startup-id $screenshot        | $copy_image
      bindsym control+shift+4 exec --no-startup-id $screenshot_select | $copy_image
      bindsym mod4+shift+3    exec --no-startup-id $screenshot        $image_path
      bindsym mod4+shift+4    exec --no-startup-id $screenshot_select $image_path

      # ames: https://github.com/eshrh/ames
      bindsym $mod+n     exec --no-startup-id ames -c
      bindsym $mod+m     exec --no-startup-id ames -r
      bindsym $mod+comma exec --no-startup-id ames -w

      # set directions
      set $up k
      set $down j
      set $left h
      set $right l

      # Use Mouse+$mod to drag floating windows to their wanted position
      floating_modifier $mod

      # start a terminal
      # bindsym $mod+Return exec i3-sensible-terminal
      # --no-startup-id because alacritty does not send the proper response
      # https://github.com/alacritty/alacritty/issues/868
      bindsym $mod+Return exec --no-startup-id alacritty

      # kill focused window
      bindsym $mod+$sup+q kill

      # start dmenu (a program launcher)
      bindsym $mod+d exec --no-startup-id dmenu_run
      # A more modern dmenu replacement is rofi:
      # bindcode $mod+40 exec "rofi -modi drun,run -show drun"
      # There also is i3-dmenu-desktop which only displays applications shipping a
      # .desktop file. It is a wrapper around dmenu, so you need that installed.
      # bindcode $mod+40 exec --no-startup-id i3-dmenu-desktop

      # change focus
      bindsym $mod+$left focus left
      bindsym $mod+$down focus down
      bindsym $mod+$up focus up
      bindsym $mod+$right focus right

      # alternatively, you can use the cursor keys:
      # bindsym $mod+Left focus left
      # bindsym $mod+Down focus down
      # bindsym $mod+Up focus up
      # bindsym $mod+Right focus right

      # move focused window
      bindsym $mod+$sup+$left move left
      bindsym $mod+$sup+$down move down
      bindsym $mod+$sup+$up move up
      bindsym $mod+$sup+$right move right

      # alternatively, you can use the cursor keys:
      # bindsym $mod+$sup+Left move left
      # bindsym $mod+$sup+Down move down
      # bindsym $mod+$sup+Up move up
      # bindsym $mod+$sup+Right move right

      # split in horizontal orientation
      bindsym $mod+semicolon split h

      # split in vertical orientation
      bindsym $mod+v split v

      # enter fullscreen mode for the focused container
      bindsym $mod+f fullscreen toggle

      # change container layout (stacked, tabbed, toggle split)
      # bindsym $mod+s layout stacking
      # bindsym $mod+w layout tabbed
      bindsym $mod+e layout toggle split

      # toggle tiling / floating
      bindsym $mod+$sup+space floating toggle

      # change focus between tiling / floating windows
      bindsym $mod+space focus mode_toggle

      # focus the parent container
      bindsym $mod+a focus parent

      # focus the child container
      bindsym $mod+s focus child

      # Define names for default workspaces for which we configure key bindings later on.
      # We use variables to avoid repeating the names in multiple places.
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

      # switch to workspace
      bindsym $mod+1 workspace number $ws1
      bindsym $mod+2 workspace number $ws2
      bindsym $mod+3 workspace number $ws3
      bindsym $mod+4 workspace number $ws4
      bindsym $mod+5 workspace number $ws5
      bindsym $mod+6 workspace number $ws6
      bindsym $mod+7 workspace number $ws7
      bindsym $mod+8 workspace number $ws8
      bindsym $mod+9 workspace number $ws9
      bindsym $mod+0 workspace number $ws10

      bindsym $mod+z workspace back_and_forth
      bindsym $mod+bracketleft   workspace prev
      bindsym $mod+bracketright  workspace next

      # move focused container to workspace
      bindsym $mod+$sup+1 move container to workspace number $ws1
      bindsym $mod+$sup+2 move container to workspace number $ws2
      bindsym $mod+$sup+3 move container to workspace number $ws3
      bindsym $mod+$sup+4 move container to workspace number $ws4
      bindsym $mod+$sup+5 move container to workspace number $ws5
      bindsym $mod+$sup+6 move container to workspace number $ws6
      bindsym $mod+$sup+7 move container to workspace number $ws7
      bindsym $mod+$sup+8 move container to workspace number $ws8
      bindsym $mod+$sup+9 move container to workspace number $ws9
      bindsym $mod+$sup+0 move container to workspace number $ws10

      bindsym $mod+$sup+z move container to workspace back_and_forth
      bindsym $mod+$sup+bracketleft  move container to workspace prev
      bindsym $mod+$sup+bracketright move container to workspace next

      # reload the configuration file
      bindsym $mod+$sup+c reload
      # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
      bindsym $mod+$sup+r restart
      # exit i3 (logs you out of your X session)
      # bindsym $mod+$sup+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"
      bindsym $mod+$sup+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'lbrplay desktop-logout; i3-msg exit'"

      # resize window (you can also use the mouse for that)
      mode "resize" {
            # These bindings trigger as soon as you enter the resize mode

            # Pressing left will shrink the window's width.
            # Pressing right will grow the window's width.
            # Pressing up will shrink the window's height.
            # Pressing down will grow the window's height.
            bindsym $left resize shrink width 10 px or 10 ppt
            bindsym $down resize grow height 10 px or 10 ppt
            bindsym $up resize shrink height 10 px or 10 ppt
            bindsym $right resize grow width 10 px or 10 ppt

            # same bindings, but for the arrow keys
            bindsym Left resize shrink width 10 px or 10 ppt
            bindsym Down resize grow height 10 px or 10 ppt
            bindsym Up resize shrink height 10 px or 10 ppt
            bindsym Right resize grow width 10 px or 10 ppt

            # back to normal: Enter or Escape or $mod+r
            bindsym Return mode "default"
            bindsym Escape mode "default"
            bindsym $mod+r mode "default"
      }

      bindsym $mod+r mode "resize"
    '';
  };
}
