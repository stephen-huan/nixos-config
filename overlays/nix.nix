final: prev:

let
  self = prev.nix;
  sh = "${final.busybox-sandbox-shell}/bin/sh";
in
{
  nix' = self.overrideAttrs (previousAttrs: {
    preConfigure = previousAttrs.preConfigure or "" + ''
      substituteInPlace src/libmain/shared.cc \
        --replace "/bin/sh" "${sh}"
    '';
  });
}
