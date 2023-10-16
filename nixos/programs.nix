{
  programs = {
    # disable default nano
    nano.enable = false;
    # for impermanence
    fuse.userAllowOther = true;
    fish.enable = true;
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
  };
}
