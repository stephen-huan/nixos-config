{ lib, config, ... }:

{
  home.persistence.${lib.homeDir config} = {
    allowOther = true;
    # uses `bindfs` (https://bindfs.org/) rather than `mount --bind`
    directories = [ ];
    files = [ ];
  };
}
