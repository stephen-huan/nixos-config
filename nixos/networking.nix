{ config, pkgs, ... }:

{
  networking = {
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
      runHook = ''
        # disable wifi if ethernet connected and
        # enable wifi if ethernet disconnected
        # https://bugs.archlinux.org/task/67382#comment191690
        wired=eno1
        wireless=wlan0

        if [ "$interface" = $wired ]; then
          case "$reason" in NOCARRIER|BOUND)
            if $if_up; then
              # ethernet up means wifi down
              iwctl station $wireless disconnect
            elif $if_down; then
              # ethernet down means wifi up
              # parse `iwctl known-networks list` and connect to most recent
              last="$(${pkgs.iwd-last-network}/bin/iwd-last-network)"
              iwctl station $wireless connect "$last"
            fi
            ;;
          esac
        fi
      '';
    };
  };
  services = {
    unbound.enable = true;
    mullvad-vpn = {
      enable = true;
      enableExcludeWrapper = false;
      package = pkgs.mullvad; # cli only
    };
  };
  systemd.services = {
    dhcpcd.path = [ pkgs.iwd ];
    iwd.path = [ config.networking.resolvconf.package ];
  };
  # could also set $MULLVAD_SETTINGS_DIR
  environment.etc."mullvad-vpn".source = "/var/lib/mullvad-vpn";
}
