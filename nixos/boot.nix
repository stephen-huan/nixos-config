{
  boot = {
    # https://wiki.archlinux.org/title/Kernel_mode_setting#Early_KMS_start
    initrd.kernelModules = [ "amdgpu" ];
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
