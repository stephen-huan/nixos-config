{ lib, ... }:

{
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "nvidia-persistenced"
    "nvidia-settings"
    "nvidia-x11"
  ];
}
