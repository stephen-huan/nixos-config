final: prev:

let
  self = prev.cmus;
in
{
  cmus = self.overrideAttrs (previousAttrs: {
    patches = previousAttrs.patches or [ ] ++ [
      # https://github.com/cmus/cmus/pull/1268
      (final.fetchpatch2 {
        name = "pipewire-stream-drain.patch";
        url = "https://github.com/cmus/cmus/commit/7adf497597e7ca83c866bce61c4ca7c2ac4a72d5.diff";
        hash = "sha256-4AN/Iskrn8UOq3YjiY3A+Xe8kGHQF1xJGxpu+TZPNA0=";
      })
    ];
  });
}
