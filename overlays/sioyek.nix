final: prev:

let
  self = prev.sioyek;
  sioyek' = self.overrideAttrs (previousAttrs: {
    src = final.fetchFromGitHub {
      owner = "ahrm";
      repo = "sioyek";
      rev = "a3aeca4864976a0d09572c58f61da0b2b9896481";
      sha256 = "sha256-2i54zNe8IOI80/qPTVI4iMCt5H1griDlfOHTqGw5eig=";
    };
    buildInputs = previousAttrs.buildInputs ++ [ final.qt6.qtspeech ];
    patches = [ ];
  });
in
{
  sioyek = final.qt6.callPackage sioyek'.override { };
}
