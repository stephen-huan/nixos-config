{
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    # Configure keymap in X11
    # xserver.layout = "us";
    # xserver.xkbOptions = "eurosign:e,caps:escape";
    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;
    displayManager = {
      defaultSession = "none+i3";
      sddm.enable = true;
      autoLogin = {
        enable = true;
        user = "ikue";
      };
    };
    windowManager.i3.enable = true;
  };
}