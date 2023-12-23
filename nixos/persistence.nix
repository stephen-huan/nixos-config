{ config, lib, ... }:

let
  inherit (config._module.args) persistent;
  persistPaths = rules:
    builtins.mapAttrs
      (name: _: { L = { argument = "${persistent}${name}"; }; })
      rules
    // lib.mapAttrs'
      (name: value: { name = "${persistent}${name}"; value = { d = value; }; })
      rules;
in
{
  environment.persistence.default = {
    persistentStoragePath = persistent;
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
  systemd.tmpfiles.settings."00-persistence" = persistPaths ({
    "/var/lib/bluetooth" = { mode = "0700"; user = "root"; group = "root"; };
    "/var/lib/iwd" = { mode = "0700"; user = "root"; group = "root"; };
    "/var/lib/mullvad-vpn" = { mode = "0755"; user = "root"; group = "root"; };
  } // lib.optionalAttrs config.services.unbound.enable {
    "${config.services.unbound.stateDir}" = {
      mode = "0755"; inherit (config.services.unbound) user group;
    };
  });
}
