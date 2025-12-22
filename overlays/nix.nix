final: prev:

let
  self = prev.nix;
  sh = "${final.busybox-sandbox-shell}/bin/sh";
in
{
  nix' = self.overrideAttrs (previousAttrs: {
    preBuild = previousAttrs.preBuild or "" + ''
      substituteInPlace src/libmain/shared.cc \
        --replace-fail "/bin/sh" "${sh}"
    '';
  });
}
