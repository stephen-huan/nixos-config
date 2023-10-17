{ config, pkgs, ... }:

let
  inherit (config._module.args) username;
  password-store = "/home/${username}/.password-store/encryption/tuxedo";
in
{
  users = {
    mutableUsers = false;
    users.${username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # enable `sudo` for the user
      hashedPasswordFile = "${password-store}/${username}.yescrypt";
      shell = pkgs.fish;
    };
    users.root.hashedPasswordFile = "${password-store}/root.yescrypt";
  };
}
