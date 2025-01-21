{ config, ... }:

let
  inherit (config._module.args) username;
in
{
  services.earlyoom = {
    enable = true;
    enableNotifications = true;
    freeMemThreshold = 20;
    # kill as soon as swap is used
    freeSwapThreshold = 100;
    freeSwapKillThreshold = 100;
  };
  systemd = {
    # https://github.com/NixOS/nixpkgs/issues/374959
    services.earlyoom.serviceConfig.User = username;
    # https://discourse.nixos.org/t/nix-build-ate-my-ram/35752
    slices.nix-daemon.sliceConfig = {
      ManagedOOMMemoryPressure = "kill";
      ManagedOOMMemoryPressureLimit = "50%";
    };
    services.nix-daemon.serviceConfig = {
      Slice = "nix-daemon.slice";
      OOMScoreAdjust = 1000;
    };
  };
  nix.settings.cores = 8;
}
