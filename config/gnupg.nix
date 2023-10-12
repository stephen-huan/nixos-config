{
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "qt";
    defaultCacheTtl = 1800; # 30 minutes, resets with usage
    maxCacheTtl = 7200; # 2 hours, maximum
  };
}
