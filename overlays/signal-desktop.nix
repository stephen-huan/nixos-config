final: prev:

let
  self = prev.signal-desktop.override {
    withAppleEmojis = true;
  };
in
{
  # revert https://github.com/NixOS/nixpkgs/pull/337161
  signal-desktop = self.overrideAttrs (previousAttrs: {
    meta = previousAttrs.meta // {
      license = final.lib.dropEnd 1 previousAttrs.meta.license;
    };
  });
}
