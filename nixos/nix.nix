{ config, ... }:

{
  nix = {
    channel.enable = false;
    settings = {
      trusted-users = [ "root" config._module.args.username "@wheel" ];
      use-xdg-base-directories = true;
    };
  };
}
