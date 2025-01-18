final: prev:

let
  self = prev.sioyek;
in
{
  sioyek = self.overrideAttrs {
    src = final.fetchFromGitHub {
      owner = "ahrm";
      repo = "sioyek";
      rev = "3a09b1664de2a58de6298c247714a8f3d3d1aa99";
      sha256 = "sha256-TBvwO0vNfNv1X+DozZ1IqYzkznJELJ/nA4NHhWCfsKo=";
    };
  };
}
