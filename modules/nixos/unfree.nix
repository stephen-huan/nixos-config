{ config, lib, ... }:

let
  inherit (lib) mkOption types;
  cfg = config.unfreePackages;
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

  config = {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg)
      (map lib.getName cfg);
  };
}
