{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.caffeine-ng ];
  services.caffeine.enable = true;
  systemd.user.services.caffeine.Service = {
    # gtk_icon_theme_get_for_screen: assertion 'GDK_IS_SCREEN (screen)' failed
    PrivateTmp = lib.mkForce false;
    # Failed to set up mount namespacing: /run/systemd/mount-rootfs/usr
    ProtectSystem = lib.mkForce false;
    # Permission denied: '/run/user/1000/caffeine-ng/pid'
    ProtectHome = lib.mkForce false;
  };
  home.persistence.${lib.persistentHome config}.directories = [
    { directory = ".config/caffeine"; method = "symlink"; }
  ];
}
