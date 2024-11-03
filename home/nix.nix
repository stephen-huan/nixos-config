{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      flake-registry = "";
      use-registries = false;
      keep-outputs = true;
      use-xdg-base-directories = true;
    };
  };
}
