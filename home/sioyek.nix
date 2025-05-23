{
  programs.sioyek = {
    enable = true;
    config = {
      # configure the appearance of page separator
      # setting to 1 will sometimes not render in specific places
      page_separator_width = "2";
      page_separator_color = "0.9 0.9 0.9";
      # if set, we open a new sioyek window when a new file is opened,
      # otherwise we open the file in the previous window
      should_launch_new_window = "1";
      # https://github.com/ahrm/sioyek/issues/1297
      # disable for latex reasons
      should_launch_new_instance = "0";
    };
  };
}
