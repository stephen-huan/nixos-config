{
  xsession = {
    enable = true;
    profileExtra = ''
      # automatically determine monitor layout
      xlayoutdisplay

      # change keybindings with X keyboard extension
      test -f ~/.Xkeymap && xkbcomp ~/.Xkeymap "$DISPLAY"

      # typematic rate (225 ms delay, 25 hz output)
      xset r rate 225 25

      # clipboard manager
      clipster --daemon &

      # screensaver after 30 minutes of inactivity
      xset s 1800
      xss-lock --transfer-sleep-lock -- \
        i3lock --nofork --image="$HOME/Pictures/config/screensaver" &

      # login alert sound: should be desktop-login but I like service-login
      canberra-gtk-play --id=service-login &
    '';
  };
}
