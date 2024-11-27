final: prev:

let
  self = prev.sioyek;
in
{
  sioyek = self.overrideAttrs {
    src = final.fetchFromGitHub {
      owner = "ahrm";
      repo = "sioyek";
      rev = "206177af8fbccaf7dc43517ee721ef9464b17624";
      sha256 = "sha256-QwuNRIroGEUM1PhOYZSo0yTUPMn39gfq3q85TXVDMyU=";
    };
  };
}
