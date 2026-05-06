{ pkgs, ... }:

let
  systemd = pkgs.systemd.overrideAttrs (previousAttrs: {
    patches = previousAttrs.patches or [ ] ++ [
      ./0001-core-namespace-support-ProtectSystem-without-usr.patch
      ./0002-update-done-default-to-current-time-without-usr.patch
      ./0003-core-main-run-if-usr-is-not-populated.patch
      ./0004-base-filesystem-avoid-creating-bin-and-usr.patch
    ];
  });
in
{
  systemd.package = systemd;
  boot.initrd.systemd.package = systemd;
}
