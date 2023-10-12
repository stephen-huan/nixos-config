{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ikue";
  home.homeDirectory = "/home/ikue";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # pkgs.alacritty # glx
    pkgs.alass
    pkgs.android-tools
    pkgs.caffeine-ng
    pkgs.chromium
    pkgs.du-dust
    pkgs.gpick
    pkgs.hicolor-icon-theme # for caffeine-ng
    pkgs.htop
    pkgs.hwinfo
    pkgs.jq
    # pkgs.krita # glx
    pkgs.mupdf
    pkgs.ncdu
    pkgs.nixos-install-tools
    pkgs.pandoc
    pkgs.pulsemixer
    pkgs.shellcheck
    # pkgs.signal-desktop # current version is too new
    # pkgs.sioyek # glx
    pkgs.tokei
    pkgs.unzip
    pkgs.yubikey-manager
    pkgs.zathura
    pkgs.zbar
    pkgs.zip
    pkgs.zotero

    pkgs.python311Packages.cython

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ] ++ (import ./unfree.nix pkgs);

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/stephenhuan/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}
