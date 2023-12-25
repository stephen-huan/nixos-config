{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      flake-registry = "";
      use-registries = false;
      keep-outputs = true;
      use-xdg-base-directories = true;
    };
  };
}
