{ pkgs, ... }:

{
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-qt;
    # 30 minutes, resets with usage
    defaultCacheTtl = 1800;
    # 2 hours, maximum
    maxCacheTtl = 7200;
  };
}
