final: prev:

let
  self = prev.gpick;
in
{
  # https://github.com/NixOS/nixpkgs/pull/371989
  gpick = self.overrideAttrs (previousAttrs: {
    patches = previousAttrs.patches or [ ] ++ [
      (final.fetchpatch2 {
        url = "https://patch-diff.githubusercontent.com/raw/thezbyg/gpick/pull/227.patch";
        hash = "sha256-3a5P/e+Nlv+y2b18jus/c6YtqNjx/5wJ4WXEUwmWB9g=";
      })
    ];
  });
}
