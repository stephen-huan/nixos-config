final: prev:

let
  self = prev.sioyek;
  sioyek' = self.overrideAttrs (previousAttrs: {
    src = final.fetchFromGitHub {
      owner = "ahrm";
      repo = "sioyek";
      rev = "b312fe0b7ae4b8125febef4467480367e0030665";
      sha256 = "sha256-0UCFp52mSEHFuH50FD+CrvmiR9SWfgqm8gUypX7gLG4=";
    };
    buildInputs = previousAttrs.buildInputs ++ [ final.qt6.qtspeech ];
    patches = [ ];
  });
in
{
  sioyek = final.qt6.callPackage sioyek'.override { };
}
