{ config, pkgs, ... }:

{
  networking = {
    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    hostName = config._module.args.hostname;
    firewall.enable = true;
    wireless.iwd.enable = true;
    useDHCP = false;
    interfaces = {
      eno1.useDHCP = true;
      wlan0.useDHCP = true;
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
}
