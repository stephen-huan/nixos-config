{
  home.persistence."/persistent/home/ikue" = {
    allowOther = true;
    # uses `bindfs` (https://bindfs.org/) rather than `mount --bind`
    directories = [ ];
    files = [ ];
  };
}
