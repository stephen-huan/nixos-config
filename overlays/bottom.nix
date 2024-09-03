final: prev:

let
  self = prev.bottom;
in
{
  bottom = self.overrideAttrs (previousAttrs: {
    patches = previousAttrs.patches or [ ] ++ [
      # https://github.com/ClementTsang/bottom/pull/1578
      (final.fetchpatch2 {
        name = "selected-text.patch";
        url = "https://patch-diff.githubusercontent.com/raw/ClementTsang/bottom/pull/1578.diff";
        hash = "sha256-V9vQ4fkXP6n2zJY01ODsmGgnROlGPGzPdzYdbw75KvQ=";
      })
    ];
  });
}
