{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    ignores = import ./gitignore.nix;
    lfs.enable = true;
    signing = {
      key = null;
      signByDefault = true;
    };
    settings = {
      user = {
        name = "Stephen Huan";
        email = "stephen.huan@cgdct.moe";
      };
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
      "credential \"https://codeberg.org\"" = {
        provider = "generic";
      };
      alias = {
        a = "add --all";
        tree = "log --graph --decorate --pretty=oneline --abbrev-commit";
      };
    };
  };
}
