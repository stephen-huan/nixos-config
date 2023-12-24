final: prev:

let
  sh = "${final.busybox-sandbox-shell}/bin/sh";
  libc = final.glibc.overrideAttrs (previousAttrs: {
    postPatch = previousAttrs.postPatch or "" + ''
      substituteInPlace \
        sysdeps/generic/paths.h \
        sysdeps/posix/system.c \
        sysdeps/unix/sysv/linux/paths.h \
        --replace "/bin/sh" "${sh}"
    '';
  });
in
{
  # https://nixos.wiki/wiki/C#Get_a_compiler_without_default_libc
  gcc' = final.wrapCCWith {
    inherit (final.gcc) cc;
    bintools = final.wrapBintoolsWith {
      bintools = final.binutils-unwrapped;
      inherit libc;
    };
  };
}
