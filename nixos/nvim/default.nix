{
  programs = {
    # replace default nano with (hardened) neovim
    nano.enable = false;
    neovim = {
      enable = true;
      defaultEditor = true;
      configure.customRC = "luafile ${./init.lua}";
    };
  };
}
