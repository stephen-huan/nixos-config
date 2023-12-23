final: prev:

let
  packages = final.lib.makeScope final.newScope (self: {
    # https://nixos.wiki/wiki/C#Use_a_different_compiler_version
    stdenv = final.overrideCC final.stdenv final.gcc';
    # not strictly necessary but might as well
    perl = final.perl';
    perlPackages = final.perlPackages // { inherit (self) perl; };
  } // addFlags {
    gawk = self.callPackage prev.gawk.override { };
    gnugrep = self.callPackage prev.gnugrep.override { };
    xdg-utils = self.callPackage prev.xdg-utils.override { };

    i3 = self.callPackage prev.i3.override { };
    silver-searcher = self.callPackage prev.silver-searcher.override { };
    xlayoutdisplay = self.callPackage prev.xlayoutdisplay.override { };

    xrdb = self.callPackage prev.xorg.xrdb.override { };
  } // {
    xorg = final.xorg // { inherit (self) xrdb; };
  });
  addFlags = pkgs: builtins.mapAttrs
    (_: pkg: pkg.overrideAttrs (previousAttrs: {
      # https://github.com/NixOS/nixpkgs/issues/129595#issuecomment-897979569
      env.NIX_CFLAGS_COMPILE = "-isysroot nowhere "
        + final.lib.attrByPath [ "NIX_CFLAGS_COMPILE" ] "" previousAttrs
        + final.lib.attrByPath [ "env" "NIX_CFLAGS_COMPILE" ] "" previousAttrs;
    }))
    pkgs;
in
{
  # we cannot overlay these, probably because they're in stdenv
  gawk' = packages.gawk;
  gnugrep' = packages.gnugrep;
  # overlaying xdg-utils triggers a mass rebuild
  xdg-utils' = packages.xdg-utils;

  inherit (packages)
    i3
    silver-searcher
    xlayoutdisplay;

  xorg = prev.xorg // { inherit (packages.xorg) xrdb; };
}
