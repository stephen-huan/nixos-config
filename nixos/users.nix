{ pkgs, ... }:

let
  password-store = "/home/ikue/.password-store/encryption/tuxedo";
in
{
  users = {
    mutableUsers = false;
    users.ikue = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # enable `sudo` for the user
      hashedPasswordFile = "${password-store}/ikue.yescrypt";
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
