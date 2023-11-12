{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # add user bin to $PATH
      fish_add_path ~/bin

      # https://askubuntu.com/a/1046546
      set -gx LESS "RF"
      set -gx LESSCHARSET "utf-8"
      set -gx LESS_TERMCAP_mb (set_color brred)
      set -gx LESS_TERMCAP_md (set_color brred)
      set -gx LESS_TERMCAP_me (set_color normal)
      set -gx LESS_TERMCAP_se (set_color normal)
      set -gx LESS_TERMCAP_so (set_color -b blue bryellow)
      set -gx LESS_TERMCAP_ue (set_color normal)
      set -gx LESS_TERMCAP_us (set_color brgreen)
    '';
  };
  home.packages = with pkgs.fishPlugins; [ fish-command-timer fzf z ];
}
