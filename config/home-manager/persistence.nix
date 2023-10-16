{ config, ... }:

{
  home.persistence."/persistent${config.home.homeDirectory}" = {
    allowOther = true;
    # uses `bindfs` (https://bindfs.org/) rather than `mount --bind`
    directories = [ ];
    files = [ ];
  };
}
