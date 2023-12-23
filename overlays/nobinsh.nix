final: prev:

let
  packages = final.lib.makeScope final.newScope (self: {
    # https://nixos.wiki/wiki/C#Use_a_different_compiler_version
    stdenv = final.overrideCC final.stdenv final.gcc';
    # not strictly necessary but might as well
    perl = final.perl';

    i3 = self.callPackage prev.i3.override { };
    xlayoutdisplay = self.callPackage prev.xlayoutdisplay.override { };
    xrdb = self.callPackage prev.xorg.xrdb.override { };
    xorg = final.xorg // {
      inherit (self)
        xrdb;
    };
  });
  addFlags = pkgs: builtins.mapAttrs
    # https://github.com/NixOS/nixpkgs/issues/129595#issuecomment-897979569
    (_: pkg: pkg.overrideAttrs { NIX_CFLAGS_COMPILE = "-isysroot nowhere"; })
    pkgs;
in
(addFlags {
  inherit (packages)
    i3
    xlayoutdisplay;
}) // {
  xorg = prev.xorg // (addFlags {
    inherit (packages.xorg)
      xrdb;
  });
}
