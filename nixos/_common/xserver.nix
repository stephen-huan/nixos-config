{
  services.xserver = {
    enable = true;
    # Configure keymap in X11
    # layout = "us";
    # xkbOptions = "eurosign:e,caps:escape";
    # Enable touchpad support (enabled default in most desktopManager).
    # libinput.enable = true;
    desktopManager = {
      runXdgAutostartIfNone = true;
      wallpaper.mode = "scale";
    };
    windowManager.i3.enable = true;
  };
  services.libinput = {
    mouse.accelProfile = "flat";
  };
}
