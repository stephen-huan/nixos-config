{ config, pkgs, ... }:

let
  home = "config";
in
{
  # loads *.nix files and directories with default.nix
  imports = map (path: ./${home}/${path})
    (builtins.attrNames (builtins.readDir ./${home}));
}
