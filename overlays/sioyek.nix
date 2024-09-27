final: prev:

let
  self = prev.sioyek;
  sioyek' = self.overrideAttrs (previousAttrs: {
    src = final.fetchFromGitHub {
      owner = "ahrm";
      repo = "sioyek";
      rev = "ae733e927a4bddc49abe81b96a1d96361736ea52";
      sha256 = "sha256-kErb8PZmp670D7/+oJfKllVD/ypgNNFdx74kIaYiXsw=";
    };
    buildInputs = previousAttrs.buildInputs ++ [ final.qt6.qtspeech ];
    patches = [ ];
  });
in
{
  sioyek = final.qt6.callPackage sioyek'.override { };
}
