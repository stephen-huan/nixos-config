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
  version = "20231120";

  srcs = [
    mozc.src
    (fetchFromGitHub rec {
      name = repo;
      owner = "utuhiro78";
      repo = "merge-ut-dictionaries";
      rev = "6b82871b11693cde9e312009bf47b2c66f1b1cfe";
      hash = "sha256-PyY7ADmhc/wk+Df4v1Yk6LWUzNZAu4eV/x53maxmVzM=";
    })
    (fetchurl {
      url = "https://dumps.wikimedia.org/jawiki/${version}/jawiki-${version}-all-titles-in-ns0.gz";
      hash = "sha256-OkalMQ9+niVz7bQnERV4ZvM0p0ChbzrOAuYX99MvQ/4=";
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
    rev = "acfe3631fc82a7c2ddb929a922f93a9e36191a99";
    hash = "sha256-bjTM+PhBiyFpoIq+WaVBaIMme5D4pZBVq4hp1n1jYgE=";
  }) ++ lib.optional jawiki (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-jawiki";
    rev = "3eccc6bc1cb818639d4323339c540995c60ce2ed";
    hash = "sha256-OtCD5k/VWmMcHQwPTFqHv/SlCSAyoxIGPe0mHU5zZQc=";
  }) ++ lib.optional neologd (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-neologd";
    rev = "be2a153f413dee01b8fa0cfdced845dcd1509b1d";
    hash = "sha256-6JBXrQKMxfk8VZZL1JMIziW+R0V97oZKsvnpiqu9xAs=";
  }) ++ lib.optional personal-names (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-personal-names";
    rev = "363da782f56cab70342b996b8c85436431f34cb4";
    hash = "sha256-t+hMSx9znV4URDo81qJdmAnE/s2LhiITnmlSSskHPfo=";
  }) ++ lib.optional place-names (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-place-names";
    rev = "24f96d2efe9da666565fe111abfda5d0b9e8dc8e";
    hash = "sha256-tFXGG+p6jDSizZrY2nUDvqlnqol7v61KEPNNapRDrXE=";
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
    rev = "b35267f2cdb3d07876fb0581df4c7cf75af7ddd4";
    hash = "sha256-IShm2+WNtQUM4QN7DAaMl7IFKB5wOi5lR5puADcq/mo=";
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
    ./local-mozc.patch
    ./local-jawiki.patch
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
