final: prev:

let
  self = prev.xlayoutdisplay;
in
{
  xlayoutdisplay = self.overrideAttrs (previousAttrs: {
    patches = previousAttrs.patches or [ ] ++ [
      # https://github.com/NixOS/nixpkgs/pull/441276
      (final.fetchpatch2 {
        name = "cpp-version.patch";
        url = "https://github.com/alex-courtis/xlayoutdisplay/commit/56983b45070edde78cc816d9cff4111315e94a7a.patch";
        hash = "sha256-zd28Nkw8Kmm20zGT6wvdBHcHfE4p+RFotUO9zJwPQMc=";
      })
    ];
  });
}
