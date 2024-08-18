{ lib, ... }:

{
  services.displayManager.autoLogin.enable = lib.mkForce false;
}
