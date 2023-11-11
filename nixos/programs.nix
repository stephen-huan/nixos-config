{
  programs = {
    # for impermanence
    fuse.userAllowOther = true;
    fish.enable = true;
    firefox.enable = true;
    browserpass.enable = true;
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
  };
}
