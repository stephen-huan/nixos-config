{ config, pkgs, ... }:

let
  inherit (config._module.args) hostname username persistent;
  home = "${persistent}${config.users.users.${username}.home}";
  password-store = "${home}/.password-store/encryption/${hostname}";
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
