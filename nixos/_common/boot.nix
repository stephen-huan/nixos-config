{ lib, ... }:

{
  boot = {
    # debug shell on tty9 (ctrl+alt+f9)
    kernelParams = lib.mkIf false [ "rd.systemd.debug_shell" ];
    loader = {
      efi.canTouchEfiVariables = false;
      systemd-boot = {
        enable = true;
        editor = false;
      };
    };
  };
}
