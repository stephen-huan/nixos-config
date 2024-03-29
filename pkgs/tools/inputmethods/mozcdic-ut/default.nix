{ lib
, stdenvNoCC
, fetchFromGitHub
, fetchurl
, ibus-engines
, mozc ? ibus-engines.mozc
, glibcLocales
, ruby
, alt-cannadic ? false
, edict ? false
, jawiki ? true
, neologd ? true
, personal-names ? true
, place-names ? true
, skk-jisyo ? false
, sudachidict ? false
}:

# see https://github.com/utuhiro78/merge-ut-dictionaries/blob/main/src/make.sh
# and https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=mozc-ut
stdenvNoCC.mkDerivation rec {
  pname = "mozcdic-ut";
  version = "20240201";

  srcs = [
    mozc.src
    (fetchFromGitHub rec {
      name = repo;
      owner = "utuhiro78";
      repo = "merge-ut-dictionaries";
      rev = "a3d6fc4005aff2092657ebca98b9de226e1c617f";
      hash = "sha256-UK29ACZUK9zGfzW7C85uMw2aF5Gk+0aDeUdNV71PY+0=";
    })
    (fetchurl {
      url = "https://dumps.wikimedia.org/jawiki/${version}/jawiki-${version}-all-titles-in-ns0.gz";
      hash = "sha256-YFj/sS9tCQcXCS1BdLarn712oul5jrDYzAmzMKLcl2A=";
    })
  ] ++ lib.optional alt-cannadic (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-alt-cannadic";
    rev = "4e548e6356b874c76e8db438bf4d8a0b452f2435";
    hash = "sha256-4gzqVoCIhC0k3mh0qbEr8yYttz9YR0fItkFNlu7cYOY=";
  }) ++ lib.optional edict (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-edict2";
    rev = "16283aa0c2d394a3a000eca4fa3e95eb365698c6";
    hash = "sha256-H4Y6RGFZBQodpB4cM3o3MPFJGs/xMvbIB/c8CazY1b4=";
  }) ++ lib.optional jawiki (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-jawiki";
    rev = "bd82687d32ae838f1e163d3d2c6ad18740af53f2";
    hash = "sha256-AjNNV1V5fTMhlR2Nv6g+zNuCCLmPlQUJtUw7JigQKdM=";
  }) ++ lib.optional neologd (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-neologd";
    rev = "bf9d0d217107f2fb2e7d1a26648ef429d9fdcd27";
    hash = "sha256-e0iM5fohwpNNhPl9CjkD753/Rgatg7GdwN0NSvlN94c=";
  }) ++ lib.optional personal-names (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-personal-names";
    rev = "6cc099cefc928bc37854c538e030114df3d5b42d";
    hash = "sha256-PqbS6VC70IaHJqxP9518zTTZuvXggAsRGeYPiN5T0XU=";
  }) ++ lib.optional place-names (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-place-names";
    rev = "a847a02e0137ab9e2fdbbaaf120826f870408ca6";
    hash = "sha256-B0kW8Wa/nCT4KEYl2Rz6gQcj0Po3GxU6i42unHhgZeU=";
  }) ++ lib.optional skk-jisyo (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-skk-jisyo";
    rev = "ee94f6546ce52edfeec0fd203030f52d4d99656f";
    hash = "sha256-RXxO878ZBkxenrdo7cFom5NjM0m7CdYQk0dFu/HPp/Y=";
  }) ++ lib.optional sudachidict (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-sudachidict";
    rev = "55f61c3fca81dec661c36c73eb29b2631c8ed618";
    hash = "sha256-gNnBcuVU1M7rllfZXIrLg7WYUhKqPJsUjR8Scnq3Fw8=";
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

  configurePhase = ''
    runHook preConfigure

    export LOCALE_ARCHIVE="${glibcLocales}/lib/locale/locale-archive"
    export LANG=ja_JP.UTF-8

    runHook postConfigure
  '';

  strictDeps = true;
  nativeBuildInputs = [ ruby ];

  buildPhase = ''
    runHook preBuild

    bash make.sh

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
