{ pkgs, ... }:

{
  programs.eza.enable = true;
  xdg.configFile."eza/theme.yml" = {
    source = (pkgs.formats.yaml { }).generate "theme.yml" {
      # roughly match ranger colors
      file_type = {
        image.foreground = "yellow";
        music.foreground = "purple";
        lossless = {
          foreground = "purple";
          is_bold = false;
          is_italic = true;
        };
        crypto = {
          foreground = "green";
          is_bold = false;
        };
      };
    };
  };
}
