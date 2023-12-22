final: prev:

let
  self = prev.caffeine-ng;
in
{
  caffeine-ng = self.overrideAttrs (previousAttrs: {
    patches = previousAttrs.patches ++ [
      (final.fetchpatch2 {
        name = "system-to-subprocess.patch";
        url = "https://codeberg.org/ikue/caffeine-ng/commit/92072f0cd105d3f355a6a76d6c433923add8e9a1.diff";
        hash = "sha256-SdsjMvLKCwe+th9fJn0GID1M2KlmzCbldiNoJHIraJs=";
      })
    ];
  });
}
