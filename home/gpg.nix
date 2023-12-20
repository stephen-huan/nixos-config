{
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "qt";
    # 30 minutes, resets with usage
    defaultCacheTtl = 1800;
    # 2 hours, maximum
    maxCacheTtl = 7200;
  };
}
