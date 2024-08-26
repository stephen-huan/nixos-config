{ lib
, stdenvNoCC
, fetchFromGitHub
, fetchurl
, ibus-engines
, mozc ? ibus-engines.mozc
, glibcLocales
, python3
, alt-cannadic ? false
, edict ? false
, jawiki ? true
, neologd ? false
, personal-names ? true
, place-names ? true
, skk-jisyo ? false
, sudachidict ? true
}:

# see https://github.com/utuhiro78/merge-ut-dictionaries/blob/main/src/make.sh
# and https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=mozc-ut
stdenvNoCC.mkDerivation rec {
  pname = "mozcdic-ut";
  version = "20240820";

  srcs = [
    mozc.src
    (fetchFromGitHub rec {
      name = repo;
      owner = "utuhiro78";
      repo = "merge-ut-dictionaries";
      rev = "1f1cdcf545b952f84fdad78d58c0db7a662b592d";
      hash = "sha256-BrjHLTomoaF/DHmxUEFVzyTWBXfB+LUtt5b/MiuZ8EU=";
    })
    (fetchurl {
      url = "https://dumps.wikimedia.org/jawiki/${version}/jawiki-${version}-all-titles-in-ns0.gz";
      hash = "sha256-zL9EtZZFDHSzKyanirhMcI0Mcs2CBz2ox6VMWox9zHs=";
    })
  ] ++ lib.optional alt-cannadic (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-alt-cannadic";
    rev = "50fee0397b87fe508f9edd45bac56f5290d8ce66";
    hash = "sha256-KKUj3d9yR2kTTTFbroZQs+OZR4KUyAUYE/X3z9/vQvM=";
  }) ++ lib.optional edict (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-edict2";
    rev = "b2112277d0d479b9218f42772356da3601b3e8cf";
    hash = "sha256-DIIp8FooWxyHMrQmq+2KUGEmYHKy+H6NtHrvRldxXqc=";
  }) ++ lib.optional jawiki (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-jawiki";
    rev = "08814f70cc0cc9b0f4757fa46f40d918dfd7073d";
    hash = "sha256-Sfw5cNXuno3aSUUPy9c3HODIu9cVSmskTwibD8w8jaM=";
  }) ++ lib.optional neologd (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-neologd";
    rev = "b7035b88db25ad1a933f05a33f193711c6c3b2db";
    hash = "sha256-JPTrWaDtdNs/Z0uLRwaS8Qc/l4/Y7NtwLanivyefXnk=";
  }) ++ lib.optional personal-names (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-personal-names";
    rev = "79e1192de922bba74ce45f59fd591f1cd9a061f5";
    hash = "sha256-5cfoeQS7H4uMRi7CQGFwdwDetihWKNVdFdON+/syvDA=";
  }) ++ lib.optional place-names (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-place-names";
    rev = "e606f2336b79bf0fa7fad3a0eb6a1a9baebafcb9";
    hash = "sha256-IKn5ge8OiAidAmqr5+F7f4b1nUPa0ZT0n+5PfvkJKAs=";
  }) ++ lib.optional skk-jisyo (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-skk-jisyo";
    rev = "7300f19e6a3f27334ed7af64589de8782549a13f";
    hash = "sha256-LJ1rP+uyh8K3IWCgKMDYt0EwEDiQqQL+wBdQCFbZM/k=";
  }) ++ lib.optional sudachidict (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-sudachidict";
    rev = "a754f1fff5fded62cc066aa6be0ab0169059a144";
    hash = "sha256-WzhWNpqtiG9TtFHEOSbHG1mbb4ak0zCkO13g9ZWqyBE=";
  });

  sourceRoot = ".";

  # see pkgs/tools/archivers/unrar/setup-hook.sh
  # and https://www.reddit.com/r/NixOS/comments/kqe57g/
  preUnpack = ''
    unpackCmdHooks+=(_tryGz)
    _tryGz() {
      if [[ "$curSrc" =~ \.tar.gz$ ]]; then return 1; fi
      if ! [[ "$curSrc" =~ \.gz$ ]]; then return 1; fi
      cp "$curSrc" "$(stripHash "$curSrc")"
    }
  '';

  postUnpack = ''
    root="merge-ut-dictionaries/src"
    mv "${mozc.src.name}" "$root/mozc"
    mv jawiki-*-all-titles-in-ns0.gz "$root/jawiki-latest-all-titles-in-ns0.gz"
    mv mozcdic-ut-* "$root"
    cd "$root"
  '';

  patches = [
    ./local-jawiki.patch
    ./local-mozc.patch
    ./local-mozcdic-ut.patch
  ];

  env = {
    LOCALE_ARCHIVE = "${glibcLocales}/lib/locale/locale-archive";
    LC_ALL = "ja_JP.UTF-8";
  };

  strictDeps = true;
  nativeBuildInputs = [ python3 ];

  buildPhase = ''
    runHook preBuild

    source make.sh

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -Dm644 mozcdic-ut.txt -t $out

    runHook postInstall
  '';

  meta = with lib; {
    description = "Multiple Mozc UT dictionaries merged into one dictionary";
    homepage = "http://linuxplayers.g1.xrea.com/mozc-ut.html";
    license = licenses.asl20;
    platforms = platforms.linux;
    maintainers = with maintainers; [ stephen-huan ];
  };
}
