{ pkgs, ... }:

{
  home.packages = [ pkgs.clipster ];
  xdg.configFile."clipster/clipster.ini".text = ''
    [clipster]

    # Number of items to save in the history file for each selection.
    # 0 - don't save history.
    history_size = 0
  '';
}
