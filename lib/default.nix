{ pkgs }:

{
  importDir = path: {
    # loads *.nix files and directories with default.nix
    imports = map (name: ../${path}/${name})
      (builtins.attrNames (builtins.readDir ../${path}));
  };
  persistentHome = config:
    "${config._module.args.persistent}${config.home.homeDirectory}";
}
