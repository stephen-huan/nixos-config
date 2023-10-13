{
  environment.persistence."/persistent" = {
    hideMounts = true;
    directories = [
      { directory = "/var/lib/bluetooth"; mode = "0700"; }
      { directory = "/var/lib/iwd"; mode = "0700"; }
      "/etc/mullvad-vpn"
      "/etc/nixos"
      "/old-root" # TODO remove
      "/var/cache"
      "/var/lib/systemd/backlight"
      "/var/lib/systemd/catalog"
      "/var/lib/systemd/coredump"
      "/var/log"
    ];
    files = [
      "/etc/machine-id"
      "/var/lib/logrotate.status"
    ];
    users.ikue = {
      directories = [
        "bin"
        ".cache"
        ".compose-cache" # TODO remove
        ".config/cmus"
        ".config/home-manager"
        ".config" # TODO more fine-grain
        ".github"
        ".gnupg"
        ".local/state/home-manager"
        ".local/state/nix"
        ".local/state/nvim"
        ".local/state/wireplumber"
        ".local" # TODO more fine-grain
        ".mozilla"
        "Music"
        "not-programs"
        ".password-store"
        ".pki" # https://bbs.archlinux.org/viewtopic.php?id=99464 (zotero->nss)
        "programs"
        ".ssh"
        ".zotero"
        "Zotero"
      ];
      files = [
        ".Xkeymap" # TODO remove
        ".xlayoutdisplay" # TODO remove
        ".xprofile" # TODO remove
      ];
    };
  };
}
