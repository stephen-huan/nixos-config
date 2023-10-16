{ config, ... }:

let
  homeDir = "${config._module.args.persistent}${config.home.homeDirectory}";
in
{
  home.persistence.${homeDir} = {
    allowOther = true;
    # uses `bindfs` (https://bindfs.org/) rather than `mount --bind`
    directories = [ ];
    files = [ ];
  };
}
