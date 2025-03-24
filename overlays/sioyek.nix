final: prev:

let
  self = prev.sioyek;
in
{
  sioyek = self.overrideAttrs {
    src = final.fetchFromGitHub {
      owner = "ahrm";
      repo = "sioyek";
      rev = "409efba2ded63182cebd2866af5cd9f03d5c9325";
      sha256 = "sha256-lpPpQ95T/61oxirrjML75TxjeQHy18+QkxWHu0VrMus=";
    };
  };
}
