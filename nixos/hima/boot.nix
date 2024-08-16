{
  boot = {
    # https://wiki.archlinux.org/title/Kernel_mode_setting#Early_KMS_start
    initrd.kernelModules = [ "amdgpu" ];
  };
}
