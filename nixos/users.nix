{ config, pkgs, ... }:

let
  username = config._module.args.username;
  password-store = "/home/${username}/.password-store/encryption/tuxedo";
in
{
  users = {
    mutableUsers = false;
    users.${username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # enable `sudo` for the user
      hashedPasswordFile = "${password-store}/${username}.yescrypt";
      packages = with pkgs; [
        # todo remove
        firefox
        tree
      ];
      shell = pkgs.fish;
    };
    users.root.hashedPasswordFile = "${password-store}/root.yescrypt";
  };
}
