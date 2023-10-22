{ config, pkgs, ... }:

{
  networking = {
    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    hostName = config._module.args.hostname;
    firewall.enable = true;
    wireless.iwd = {
      enable = true;
      settings = {
        General.EnableNetworkConfiguration = true;
        Network.NameResolvingService = "resolvconf";
      };
    };
    useDHCP = false;
    interfaces = {
      eno1.useDHCP = true;
      # configured by iwd
      wlan0.useDHCP = false;
    };
    dhcpcd = {
      enable = true;
      runHook = "";
    };
  };
  services.mullvad-vpn = {
    enable = true;
    enableExcludeWrapper = true;
    package = pkgs.mullvad; # cli only
  };
  # https://github.com/NixOS/nixpkgs/issues/262681
  systemd.services.mullvad-daemon.path = [
    config.networking.resolvconf.package
  ];
  services.unbound.enable = true;
}
