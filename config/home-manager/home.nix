{ pkgs, ... }:

{
  home = {
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager
    # release introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you
    # do want to update the value, then make sure to first check the Home
    # Manager release notes.
    stateVersion = "23.05"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = [
      pkgs.alass
      pkgs.android-tools
      pkgs.caffeine-ng
      pkgs.chromium
      pkgs.cider
      pkgs.cmus
      pkgs.du-dust
      pkgs.git-credential-manager
      pkgs.gpick
      pkgs.htop
      pkgs.hwinfo
      pkgs.ipaexfont
      pkgs.ipafont
      pkgs.jq
      pkgs.krita
      pkgs.llvmPackages_latest.libstdcxxClang
      pkgs.mdbook
      pkgs.mdbook-katex
      pkgs.mupdf
      pkgs.ncdu
      pkgs.neofetch
      pkgs.nodejs
      pkgs.nodePackages.node2nix
      pkgs.nodePackages.prettier
      pkgs.noto-fonts
      pkgs.noto-fonts-cjk-sans
      pkgs.noto-fonts-cjk-serif
      pkgs.noto-fonts-emoji
      pkgs.pandoc
      pkgs.pass
      pkgs.passExtensions.pass-otp
      pkgs.pulsemixer
      pkgs.shellcheck
      (
        # temporarily override until new version
        pkgs.signal-desktop.override {
          version = "6.34.0";
          hash = "sha256-YsmXzorTYyydFcXME6GUxn/oaVosVfnCUjAurmlK+x8=";
        }
      )
      pkgs.silver-searcher
      pkgs.texlive.combined.scheme-full
      pkgs.tokei
      pkgs.tree
      pkgs.unzip
      pkgs.vulnix
      pkgs.xclip
      pkgs.yacreader
      pkgs.yadm
      pkgs.yubikey-manager
      pkgs.zathura
      pkgs.zbar
      pkgs.zip
      pkgs.zotero

      pkgs.python311Packages.cython

      # # It is sometimes useful to fine-tune packages, for example, by
      # # applying overrides. You can do that directly here, just don't forget
      # # the parentheses. Maybe you want to install Nerd Fonts with a limited
      # # number of fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ] ++ (import ./unfree.nix pkgs);

    # Home Manager is pretty good at managing dotfiles. The primary way to
    # manage plain files is through 'home.file'.
    file = {
      ".config/black".text = ''
        [tool.black]
        line-length = 79
      '';
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
    sessionVariables = {
      # EDITOR = "emacs";
    };
  };
}
