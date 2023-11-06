{ pkgs }:

let
  lib = pkgs.lib;
in
{
  # loads *.nix files and directories with default.nix
  importDir = path: {
    imports = map (name: ../${path}/${name})
      (builtins.attrNames (builtins.readDir ../${path}));
  };
  # return the persistent home directory
  persistentHome = config:
    "${config._module.args.persistent}${config.home.homeDirectory}";
  # remove prefix from a path, if it exists
  stripPrefix = prefix: path:
    let
      start = lib.splitString "/" prefix;
      tokens = lib.splitString "/" path;
      n = builtins.length start;
      join = builtins.concatStringsSep "/";
    in
    if lib.take n tokens == start
    then join (lib.drop n tokens)
    else join tokens;
}
