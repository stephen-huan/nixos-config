final: prev:

let
  self = prev.signal-desktop;
in
{
  # revert https://github.com/NixOS/nixpkgs/pull/337161
  signal-desktop = self.override {
    withAppleEmojis = false;
  };
}
