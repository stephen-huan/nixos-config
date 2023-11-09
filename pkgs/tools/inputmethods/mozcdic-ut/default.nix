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
let
  date = "20231101";
in
stdenvNoCC.mkDerivation {
  pname = "mozcdic-ut";
  version = date;

  srcs = [
    (fetchFromGitHub {
      owner = "utuhiro78";
      repo = "merge-ut-dictionaries";
      rev = "c4daa91f69ee6d45eaec510cbaa58075d29ba820";
      hash = "sha256-pniWfQtp569gj7RfC6q/gLPt7vusetzQ3WOXPxKDYDI=";
    })
    mozc.src
    (fetchurl {
      url = "https://dumps.wikimedia.org/jawiki/${date}/jawiki-${date}-all-titles-in-ns0.gz";
      hash = "sha256-S30QNW29VRa4P7JTi7vVdqDrWChSuXFEjkDbYwnpG1A=";
    })
  ] ++ lib.optional alt-cannadic (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-alt-cannadic";
    rev = "f59287e569db3e226378380a34e71275654b46d0";
    hash = "sha256-a9U6mGlGAxbywILeAaWKbt7BFWRPFS+UZvUhliFUseY=";
  }) ++ lib.optional edict (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-edict2";
    rev = "b976b6720a9ce38bea26b457af4678ab3d76b971";
    hash = "sha256-Dv0UtqXamJSctMUUgicRp7cvT3sFNSnVMnds1XyQXik=";
  }) ++ lib.optional jawiki (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-jawiki";
    rev = "25d82b3def00c3d8b5ccff660952d317a8f5c6c6";
    hash = "sha256-eeLSudLfrMWU4b8m3avxdmtQ7Bx3PFeNy2ha3V7RZ3w=";
  }) ++ lib.optional neologd (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-neologd";
    rev = "90e59c7707a5fe250c992c10c6ceb08a7ce7e652";
    hash = "sha256-zY7K/J4OzBTQHrj8sF4s8xPqakoWHHMxWrvnvHT6oxE=";
  }) ++ lib.optional personal-names (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-personal-names";
    rev = "c96f2a22aaf2bddcca0dcb0b028ed6c7188f6e17";
    hash = "sha256-+67otaZAiC6AilZh4y/52HJbZjBNZoOS+9lJ2JRBZYU=";
  }) ++ lib.optional place-names (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-place-names";
    rev = "754722f01544c06a6bb5bb590e704d86334dc6b1";
    hash = "sha256-T3hwRVWry9OveOH4mUt5IToYqvjZby2Gv08z3neC7eE=";
  }) ++ lib.optional skk-jisyo (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-skk-jisyo";
    rev = "43518e6ea033681580a515281668c85eb74a5b14";
    hash = "sha256-05T//ulsS5HvOKPdOEG87/Yp8GgzOB2X3wG8Sds3uUU=";
  }) ++ lib.optional sudachidict (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-sudachidict";
    rev = "39c8c2c16b326a5d9ba63a9d2f13032533ae1634";
    hash = "sha256-dT0BmdTmYTL4L0Dhf2LvL2uuSdL6WWaXufm6iyRVRFs=";
  });

  sourceRoot = ".";

  unpackPhase = ''
    runHook preUnpack

    srcsArray=($srcs)
    cp -r "''${srcsArray[0]}" source
    cd source/src
    chmod -R u+w -- .
    cp "''${srcsArray[1]}/src/data/dictionary_oss/id.def" .
    cp "''${srcsArray[2]}" jawiki-latest-all-titles-in-ns0.gz
    for dict in "''${srcsArray[@]:3}"; do
      cp -r "$dict" "$(stripHash "$dict")"
    done
    chmod -R u+w -- .

    # UT辞書を展開して結合
    mv mozcdic-ut-*/mozcdic-ut-*.txt.tar.bz2 .
    for f in mozcdic-ut-*.txt.tar.bz2; do tar xf "$f"; done

    cat mozcdic-ut-*.txt > mozcdic-ut.txt

    runHook postUnpack
  '';

  configurePhase = ''
    runHook preConfigure

    export LOCALE_ARCHIVE=${glibcLocales}/lib/locale/locale-archive
    export LANG=ja_JP.UTF-8

    runHook postConfigure
  '';

  patches = [
    ./local-mozc.patch
    ./remove-wget.patch
  ];

  strictDeps = true;
  nativeBuildInputs = [ ruby ];

  buildPhase = ''
    runHook preBuild

    # mozcdic-ut.txt の重複エントリを削除
    ruby remove_duplicate_ut_entries.rb mozcdic-ut.txt

    # mozcdic-ut.txt の単語コストを変更
    ruby count_word_hits.rb
    ruby apply_word_hits.rb mozcdic-ut.txt

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
