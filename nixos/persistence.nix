{ config, lib, ... }:

let
  inherit (config._module.args) persistent;
  persistPaths = rules:
    map (rule: "d ${persistent}${rule}") rules
    ++ map
      (rule:
        let path = builtins.elemAt (lib.splitString " " rule) 0;
        in "L ${path} - - - - ${persistent}${path}")
      rules;
in
{
  environment.persistence.${persistent} = {
    hideMounts = true;
    directories = [
      "/var/cache"
      "/var/lib/systemd"
      "/var/log"
    ];
    files = [ ];
    users.${config._module.args.username} = {
      directories = [
        ".cache" # Error installing file '.cache/.keep' outside $HOME
        ".config/fish"
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
        ".local/share" # Error installing file outside $HOME
        ".local/state"
      ];
    };
  };
  systemd.tmpfiles.rules = persistPaths ([
    "/var/lib/bluetooth 0700 root root -"
    "/var/lib/iwd 0700 root root -"
    "/var/lib/mullvad-vpn 0755 root root -"
  ] ++ lib.optional config.services.unbound.enable
    "${config.services.unbound.stateDir} 0755 unbound unbound -"
  );
}
