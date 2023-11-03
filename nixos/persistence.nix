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
        "bin"
        ".cache"
        ".compose-cache" # TODO: remove
        ".config/cmus"
        ".config/fish" # TODO: nix config
        ".config/home-manager"
        ".config/memento"
        ".config/Signal"
        ".config" # TODO: more fine-grain
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
        ".julia"
        ".local/state/home-manager"
        ".local/state/nix"
        ".local/state/nvim"
        ".local/state/wireplumber"
        ".local" # TODO: more fine-grain
        ".mozilla"
        "not-programs"
        ".password-store"
        ".pki" # https://bbs.archlinux.org/viewtopic.php?id=99464 (nss)
        "programs"
        ".thunderbird"
        ".zotero"
        "Zotero"
      ];
    };
  };
}
