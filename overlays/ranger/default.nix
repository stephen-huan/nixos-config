final: prev:

let
  self = prev.ranger;
  sh = "${final.busybox-sandbox-shell}/bin/sh";
in
{
  ranger = self.overrideAttrs (previousAttrs: {
    patches = previousAttrs.patches or [ ] ++ [
      ./lazy-nix-store.patch
      ./mark-freeze.patch
    ];

    preConfigure = previousAttrs.preConfigure or "" + ''
      substituteInPlace \
        ranger/config/commands.py \
        ranger/ext/rifle.py \
        --replace "/bin/sh" "${sh}"
    '';
  });
}
