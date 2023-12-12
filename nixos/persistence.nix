{ config, ... }:

{
  environment.persistence."${config._module.args.persistent}" = {
    hideMounts = true;
    directories = [
      { directory = "/var/lib/bluetooth"; mode = "0700"; }
      { directory = "/var/lib/iwd"; mode = "0700"; }
      "/var/cache"
      "/var/lib/mullvad-vpn"
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
}
