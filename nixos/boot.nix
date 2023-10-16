{
  boot = {
    kernelParams = [ "boot.shell_on_fail" ];
    loader = {
      efi.canTouchEfiVariables = false;
      grub = {
        device = "nodev";
        efiSupport = true;
        # https://github.com/NixOS/nixpkgs/issues/243026
        efiInstallAsRemovable = true;
        extraGrubInstallArgs = [ "--disable-shim-lock" ];
        splashImage = import ./figures/splashImage.nix;
      };
    };
  };
}
