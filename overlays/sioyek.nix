final: prev:

let
  self = prev.sioyek;
in
{
  sioyek = self.overrideAttrs {
    src = final.fetchFromGitHub {
      owner = "ahrm";
      repo = "sioyek";
      rev = "bab683c46f92421427f505377ff853d2a1905200";
      sha256 = "sha256-fbS36c1Mf5IkX1i07CT3c+Y1uIraNuvifNf2oDebCD0=";
    };
  };
}
