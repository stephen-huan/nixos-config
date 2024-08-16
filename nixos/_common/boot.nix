{
  boot = {
    kernelParams = [ "boot.shell_on_fail" ];
    loader = {
      efi.canTouchEfiVariables = false;
      systemd-boot = {
        enable = true;
        editor = false;
      };
    };
  };
}
