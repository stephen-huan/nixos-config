{ lib, ... }:

{
  services.displayManager = {
    sddm = {
      enableHidpi = true;
      settings.General = {
        GreeterEnvironment = "QT_SCREEN_SCALE_FACTORS=2";
      };
    };
    autoLogin.enable = lib.mkForce false;
  };
}
