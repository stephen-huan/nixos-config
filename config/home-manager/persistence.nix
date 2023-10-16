{
  home.persistence."/persistent/home/ikue" = {
    allowOther = true;
    # uses `bindfs` (https://bindfs.org/) rather than `mount --bind`
    directories = [ ];
    files = [
      ".Xkeymap" # TODO remove
      ".xlayoutdisplay" # TODO remove
      ".xprofile" # TODO remove
    ];
  };
}
