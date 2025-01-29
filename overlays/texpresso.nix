final: prev:

let
  self = prev.texpresso;
in
{
  texpresso = self.overrideAttrs {
    src = final.fetchFromGitHub {
      owner = "let-def";
      repo = "texpresso";
      rev = "c42a5912f501f180984840fa8adf9ffc09c5ac13";
      sha256 = "sha256-T/vou7OcGtNoodCrznmjBLxg6ZAFDCjhpYgNyZaf44g=";
    };
  };
}
