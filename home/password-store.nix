{ config, pkgs, ... }:

{
  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
    settings = {
      PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
      # disable user extensions (~/.password-store/.extensions)
      PASSWORD_STORE_ENABLE_EXTENSIONS = "";
      PASSWORD_STORE_SIGNING_KEY = "EA6E27948C7DBF5D0DF085A10FBC2E3BA99DD60E";
    };
  };
  home.persistence.default.directories = [
    { directory = ".password-store"; method = "symlink"; }
  ];
}
