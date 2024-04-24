final: prev:

let
  self = final.perl;
  sh = "${final.busybox-sandbox-shell}/bin/sh";
in
rec {
  perl' = (self.overrideAttrs (previousAttrs: {
    preConfigure = previousAttrs.preConfigure or "" + ''
      cat >> config.over <<EOF
      sh="${sh}"
      startsh="#!${sh}"
      targetsh="${sh}"
      EOF
      substituteInPlace os2/os2.c \
        --replace-fail "/bin/sh" "${sh}"
    '';
    # speeds up the build from ~5 minutes to ~2 minutes
    enableParallelBuilding = true;
  })).override {
    # see pkgs/development/interpreters/perl/default.nix
    self = perl';
  };
}
