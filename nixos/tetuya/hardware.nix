{ config, ... }:

let
  inherit (config._module.args) persistent;
in
{
  hardware = {
    cpu.intel.updateMicrocode = true;
  };
  swapDevices = [{
    device = "${persistent}/var/lib/swapfile";
    size = 32 * 1024;
    randomEncryption.enable = true;
  }];
  services.fwupd.enable = true;
}
