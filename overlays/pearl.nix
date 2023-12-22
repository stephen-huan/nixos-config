final: prev:

let
  self = prev.perl;
  sh = "${final.busybox-sandbox-shell}/bin/sh";
in
{
  perl' = self.overrideAttrs (previousAttrs: {
    preConfigure = previousAttrs.preConfigure + ''
      cat >> config.over <<EOF
      sh="${sh}"
      startsh="#!${sh}"
      targetsh="${sh}"
      EOF
      substituteInPlace os2/os2.c \
        --replace "/bin/sh" "${sh}"
    '';
    # speeds up the build from ~5 minutes to ~2 minutes
    enableParallelBuilding = true;
  });
}
