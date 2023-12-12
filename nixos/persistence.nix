{ config, ... }:

let
  inherit (config._module.args) persistent;
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
  systemd.tmpfiles.rules = map (dir: "L ${dir} - - - - ${persistent}${dir}") [
    "/var/lib/bluetooth"
    "/var/lib/iwd"
    "/var/lib/mullvad-vpn"
  ];
}
