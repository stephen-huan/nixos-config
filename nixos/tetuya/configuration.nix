# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, lib, pkgs, modulesPath, options, ... }:

{
  # https://elis.nu/blog/2020/05/nixos-tmpfs-as-root/
  fileSystems = {
    "/" = {
      fsType = "tmpfs";
      options = [ "defaults" "size=2G" "mode=755" ];
    };
    # manually specify because `nixos-generate-config` doesn't pick it up
    ${config._module.args.persistent} = {
      device = "/dev/disk/by-uuid/49416e00-1e7b-415e-a35a-fc7b3e6f1fed";
      fsType = "ext4";
      neededForBoot = true;
    };
    # https://nixos.wiki/wiki/Filesystems
    "/nix" = {
      device = "${config._module.args.persistent}/nix";
      options = [ "bind" ];
    };
  };
}
