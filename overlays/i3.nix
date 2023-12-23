final: prev:

let
  self = prev.i3;
in
{
  i3 = (self.override {
    # https://nixos.wiki/wiki/C#Use_a_different_compiler_version
    stdenv = final.overrideCC final.stdenv final.gcc';
    # not strictly necessary but might as well
    perl = final.perl';
  }).overrideAttrs {
    # https://github.com/NixOS/nixpkgs/issues/129595#issuecomment-897979569
    NIX_CFLAGS_COMPILE = "-isysroot nowhere";
  };
}
