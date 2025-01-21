{
  services.earlyoom = {
    enable = true;
    enableNotifications = true;
    freeMemThreshold = 20;
    # kill as soon as swap is used
    freeSwapThreshold = 100;
    freeSwapKillThreshold = 100;
  };
  # https://discourse.nixos.org/t/nix-build-ate-my-ram/35752
  systemd = {
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
