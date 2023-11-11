{
  programs = {
    # replace default nano with (hardened) neovim
    nano.enable = false;
    neovim = {
      enable = true;
      defaultEditor = true;
      configure.customRC = ''luafile ${./nvim/init.lua}'';
    };
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
