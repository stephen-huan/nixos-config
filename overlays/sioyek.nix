final: prev:

let
  self = prev.sioyek;
in
{
  sioyek = self.overrideAttrs {
    src = final.fetchFromGitHub {
      owner = "ahrm";
      repo = "sioyek";
      rev = "84030b7387221c6d3378a4aaa1a1aefef6bb6063";
      sha256 = "sha256-gA716w5mCb6mts/27RHHeebBfq7Uvcjpqlj9x1qWDZk=";
    };
  };
}
