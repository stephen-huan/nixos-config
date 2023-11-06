{ config, ... }:

{
  environment.persistence."${config._module.args.persistent}" = {
    hideMounts = true;
    directories = [
      { directory = "/var/lib/bluetooth"; mode = "0700"; }
      { directory = "/var/lib/iwd"; mode = "0700"; }
      "/etc/mullvad-vpn"
      "/etc/nixos"
      "/var/cache"
      "/var/lib/systemd/backlight"
      "/var/lib/systemd/coredump"
      "/var/log"
    ];
    files = [ "/etc/machine-id" ];
    users.${config._module.args.username} = {
      directories = [
        ".cache" # Error installing file '.cache/.keep' outside $HOME
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
        ".local/share" # Error installing file outside $HOME
        ".local/state"
      ];
    };
  };
}
