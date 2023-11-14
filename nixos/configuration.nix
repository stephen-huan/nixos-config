# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, lib, pkgs, modulesPath, options, ... }:

{
  boot.initrd.luks.devices.cryptlvm.device =
    "/dev/disk/by-uuid/5d57809c-d0e9-49e9-939e-f5d68392faf4";
  # https://elis.nu/blog/2020/05/nixos-tmpfs-as-root/
  fileSystems = {
    "/" = {
      fsType = "tmpfs";
      options = [ "defaults" "size=2G" "mode=755" ];
    };
    # manually specify because `nixos-generate-config` doesn't pick it up
    ${config._module.args.persistent} = {
      device = "/dev/VolumeGroup/root";
      fsType = "ext4";
      neededForBoot = true;
    };
    # https://nixos.wiki/wiki/Filesystems
    "/nix" = {
      device = "${config._module.args.persistent}/nix";
      options = [ "bind" ];
    };
  };
  # overwrite ./hardware-configuration.nix
  swapDevices = lib.mkForce [
    { device = "/dev/VolumeGroup/swap"; }
  ];

  environment = {
    systemPackages = with pkgs; [
      git # required for flakes
      backintime
    ];
  };
}
