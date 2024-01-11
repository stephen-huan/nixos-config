final: prev:

let
  self = prev.sioyek;
in
{
  sioyek = self.overrideAttrs {
    src = final.fetchFromGitHub {
      owner = "ahrm";
      repo = "sioyek";
      rev = "d2663366437413159e27a1e14700e6ff85fa47c1";
      sha256 = "sha256-GfwOa6tNeCh1QmK3LEmGmPrcBv4sbdzU2xTcDzFxEGw=";
    };
    patches = [
      # Fixed compatibility with mupdf-0.23.0
      # https://github.com/ahrm/sioyek/issues/804
      (final.fetchurl {
        url = "https://aur.archlinux.org/cgit/aur.git/plain/sioyek-mupdf-1.23.patch?h=sioyek-git&id=e4a1a281e737337bfb48392a8026f3a17cbfb86d";
        hash = "sha256-MAIWRv2kXECvRXkGfMsJi/9LKTT/QqznsCph/RyLxXM=";
      })
    ];
  };
}
