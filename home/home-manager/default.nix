{
  imports = [
    ./home.nix
    ./persistence.nix
  ];
  config = {
    # let home manager install and manage itself
    programs.home-manager.enable = true;
  };
}
