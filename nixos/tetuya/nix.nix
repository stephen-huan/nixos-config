{
  nix.settings = {
    # https://nix-community.org/cache/
    # https://flox.dev/blog/the-flox-catalog-now-contains-nvidia-cuda/
    substituters = [
      "https://nix-community.cachix.org?priority=41"
      "https://cache.flox.dev?priority=42"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
    ];
  };
}
