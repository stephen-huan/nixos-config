{
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  unfreePackages = [
    "nvidia-persistenced"
    "nvidia-settings"
    "nvidia-x11"
  ];
}
