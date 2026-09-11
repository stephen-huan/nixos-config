final: prev:

let
  self = prev.texpresso;
in
{
  texpresso = self.overrideAttrs (previousAttrs: {
    src = final.fetchFromGitHub {
      owner = "let-def";
      repo = "texpresso";
      rev = "e8df7709077b2f86f6e16e6c86ceefb86de06f8d";
      hash = "sha256-ijQwoQIJ6CsAd7eY9kkK2aHO/5FRFP5/tE6H9R/pngY=";
    };
  });
}
