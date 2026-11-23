{ config, lib, ... }:

let
  inherit (lib) mkOption types;
  cfg = config;
  getName = pkg: if builtins.isString pkg then pkg else lib.getName pkg;
in
{
  options.unfreePackages = mkOption {
    type = types.listOf (types.either types.package types.str);
    default = [ ];
    example = lib.literalExpression ''
      [ pkgs.signal-desktop.passthru.apple-emoji "nvidia-x11" ]
    '';
    description = ''
      List of packages to add to `nixpkgs.config.allowUnfreePredicate`.
    '';
  };

  options.insecurePackages = mkOption {
    type = types.listOf (types.either types.package types.str);
    default = [ ];
    example = lib.literalExpression ''
      [ "firefox-esr-140-bin-unwrapped" ]
    '';
    description = ''
      List of packages to add to `nixpkgs.config.allowInsecurePredicate`.
    '';
  };

  config = {
    nixpkgs.config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg)
        (map getName cfg.unfreePackages);
      allowInsecurePredicate = pkg: builtins.elem (lib.getName pkg)
        (map getName cfg.insecurePackages);
    };
  };
}
