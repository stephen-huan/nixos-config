{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      keep-outputs = true;
      use-xdg-base-directories = true;
    };
  };
}
