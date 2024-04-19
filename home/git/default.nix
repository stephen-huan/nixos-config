{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Stephen Huan";
    userEmail = "stephen03.huan@gmail.com";
    ignores = import ./gitignore.nix;
    lfs.enable = true;
    signing = {
      key = null;
      signByDefault = true;
    };
    extraConfig = {
      init.defaultBranch = "master";
      pull.rebase = true;
      push.autoSetupRemote = true;
      credential = {
        helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
        credentialStore = "gpg";
      };
      "credential \"https://git.overleaf.com\"" = {
        provider = "generic";
      };
    };
    aliases = {
      a = "add --all";
      tree = "log --graph --decorate --pretty=oneline --abbrev-commit";
    };
  };
}
