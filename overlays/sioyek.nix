final: prev:

let
  self = prev.sioyek;
in
{
  sioyek = self.overrideAttrs {
    src = final.fetchFromGitHub {
      owner = "ahrm";
      repo = "sioyek";
      rev = "66880e1ebd9a81f6d80835f21d2309ea15d13ffd";
      sha256 = "sha256-8W8a+YwK7C/qe9tIao6vXStnKN9NHBSFViXwuyhWazo=";
    };
  };
}
