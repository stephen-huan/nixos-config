{ pkgs, ... }:

{
  home.packages = [ pkgs.clipster ];
  xdg.configFile."clipster/clipster.ini" = {
    source = (pkgs.formats.ini { }).generate "clipster.ini" {
      # number of items to save in the history file for each selection
      # 0 - don't save history
      clipster.history_size = 0;
    };
  };
}
