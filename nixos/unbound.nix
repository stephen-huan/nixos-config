{ config, lib, ... }:

let
  unbound_conf = "/etc/resolvconf-unbound.conf";
  # match libc_restart (nixos/modules/config/resolvconf.nix)
  unbound_restart = "/run/current-system/systemd/bin/systemctl try-restart "
    + "--no-block unbound.service 2> /dev/null";
in
{
  config = lib.mkIf config.services.unbound.enable {
    networking = {
      resolvconf.extraConfig = ''
        unbound_conf=${unbound_conf}
        unbound_restart='${unbound_restart}'
      '';
      dhcpcd.extraConfig = "nohook resolv.conf";
      nameservers = [
        "1.1.1.1"
        "1.0.0.1"
        "2606:4700:4700::1111"
        "2606:4700:4700::1001"
      ];
    };
    services.unbound = {
      settings = {
        include = unbound_conf;
        server = {
          prefetch = true;
          hide-identity = true;
          hide-version = true;
          # tls-cert-bundle and auto-trust-anchor-file automatically set
        };
      };
    };
  };
}
