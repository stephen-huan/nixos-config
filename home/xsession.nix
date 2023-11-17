{ lib, pkgs, ... }:

{
  xsession = {
    enable = true;
    initExtra = ''
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

      # Start the desktop manager.
      /run/current-system/systemd/bin/systemctl --user start \
        xdg-autostart-if-no-desktop-manager.target

      if [ -e $HOME/.background-image ]; then
        ${lib.getExe pkgs.feh} --bg-scale $HOME/.background-image
      fi
    '';
  };
}
