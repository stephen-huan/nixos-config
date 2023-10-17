{
  services.picom = {
    enable = true;
    # use OpenGL as the rendering backend
    backend = "glx";
    # without fading, some screen tears
    fade = true;
    # speed up default fade speed
    fadeDelta = 3;
    # make inactive windows slightly transparent
    inactiveOpacity = 0.9;
    opacityRules = [
      # exclude screensaver (i3lock) window
      "100:class_g = 'i3lock'"
      # exclude floating windows
      "100:I3_FLOATING_WINDOW@:c"
    ];
  };
}
