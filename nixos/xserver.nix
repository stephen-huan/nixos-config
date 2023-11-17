{ config, ... }:

{
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    # Configure keymap in X11
    # layout = "us";
    # xkbOptions = "eurosign:e,caps:escape";
    # Enable touchpad support (enabled default in most desktopManager).
    # libinput.enable = true;
    displayManager = {
      defaultSession = "none+i3";
      sddm.enable = true;
      autoLogin = {
        enable = true;
        user = config._module.args.username;
      };
    };
    desktopManager = {
      runXdgAutostartIfNone = true;
      wallpaper.mode = "scale";
    };
    windowManager.i3.enable = true;
  };
}
