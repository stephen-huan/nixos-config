final: prev:

let
  self = prev.ranger;
  sh = "${final.busybox-sandbox-shell}/bin/sh";
in
{
  ranger = self.overrideAttrs (previousAttrs: {
    patches = [ ./lazy-nix-store.patch ];

    preConfigure = previousAttrs.preConfigure + ''
      substituteInPlace \
        ranger/config/commands.py \
        ranger/ext/rifle.py \
        --replace "/bin/sh" "${sh}"
    '';
  });
}
