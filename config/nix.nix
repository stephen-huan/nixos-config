{ pkgs, ... }:

{
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      keep-outputs = true;
    };
  };
}
