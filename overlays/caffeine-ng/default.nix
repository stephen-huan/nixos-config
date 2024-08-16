final: prev:

let
  self = prev.caffeine-ng;
in
{
  caffeine-ng = self.overrideAttrs (previousAttrs: {
    patches = previousAttrs.patches or [ ] ++ [
      ./system-to-subprocess.patch
    ];
  });
}
