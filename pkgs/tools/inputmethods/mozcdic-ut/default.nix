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
  version = "20240720";

  srcs = [
    mozc.src
    (fetchFromGitHub rec {
      name = repo;
      owner = "utuhiro78";
      repo = "merge-ut-dictionaries";
      rev = "2855b796743acb0c7d320b08d0728977bf6d0860";
      hash = "sha256-ppOsNy3yd8DndrQ6Uh8J1OdsTYhT1uYzIhZYqKxVWwQ=";
    })
    (fetchurl {
      url = "https://dumps.wikimedia.org/jawiki/${version}/jawiki-${version}-all-titles-in-ns0.gz";
      hash = "sha256-t8Q96FQEaOJs1cc9ySSrVYyD4I/DvfXh6UxvURHHHWk=";
    })
  ] ++ lib.optional alt-cannadic (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-alt-cannadic";
    rev = "b3d151c189c55b00e3e384ddb847cc76b3565746";
    hash = "sha256-1Mo8Ccdi/8VietPPB+q/fPOnKdG76uELdY9HRFfcEY8=";
  }) ++ lib.optional edict (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-edict2";
    rev = "a3febcb019454af445809965d4f64baddd962c73";
    hash = "sha256-1j2SZu2S25nnbBeVms/aErDEKzRDrh/19DC5uWsv2AY=";
  }) ++ lib.optional jawiki (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-jawiki";
    rev = "9395f09f8dd87cc4521d7986ec4239af8abcecea";
    hash = "sha256-jrXni5emy37O2e2yLldUmirVDLpHKXFyp4Prycw7DFk=";
  }) ++ lib.optional neologd (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-neologd";
    rev = "c1524034b08fad881957d72f5b29931cc5964f8c";
    hash = "sha256-KZtPQccvWz6qygrrmDzZp3SkF1pJA8ptP1oU3IvDb0k=";
  }) ++ lib.optional personal-names (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-personal-names";
    rev = "5df5cedaef3b55c509cacfbf3e97ded852535a1b";
    hash = "sha256-zTJVhbZEIG+xiRWAPsK9faxxxnKeHIt/gc7HuAXqOl4=";
  }) ++ lib.optional place-names (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-place-names";
    rev = "99cb804417a5816933d87ac9d2caeb993ea98339";
    hash = "sha256-6LP6amg8TC0XCXCdlcSRGN6qSyBfQ1k+K1FvxEd62pY=";
  }) ++ lib.optional skk-jisyo (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-skk-jisyo";
    rev = "d5bf4e970e35c0ccd51c3a24ff301ed1d0770cef";
    hash = "sha256-OBGHW0brW/JqPEKTXwpBWuNpd4hzpx7PH3p3wjwGi+8=";
  }) ++ lib.optional sudachidict (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-sudachidict";
    rev = "1aa3d3d56bf26a77010febfa87e1a6c745770dd7";
    hash = "sha256-eiV6mo4rWARlwyoy89K1vJO+YRdvRRtgCAid7Ig++qc=";
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
