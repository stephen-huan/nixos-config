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
  version = "20240501";

  srcs = [
    mozc.src
    (fetchFromGitHub rec {
      name = repo;
      owner = "utuhiro78";
      repo = "merge-ut-dictionaries";
      rev = "d44c83d4bfd947fb4369e6b0c2e6111e2f9bfaba";
      hash = "sha256-5iU44qQyYQ0e8qLsLUclrkzch6kvhbxkF/f2SrxNTHU=";
    })
    (fetchurl {
      url = "https://dumps.wikimedia.org/jawiki/${version}/jawiki-${version}-all-titles-in-ns0.gz";
      hash = "sha256-HwZKEXxFyASGz/oViFWtJrXDX9k9ySy03OW4PxIVSHQ=";
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
    rev = "4a08ebf0397c65991b5f6d7f4dd2cbc583a12c83";
    hash = "sha256-958l0Q9GKmyZojaPtyq1hD+TxSk1VHJdayrdZV6oGBQ=";
  }) ++ lib.optional jawiki (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-jawiki";
    rev = "954b0722aa3451fa36848055d75c3ec8bf80fe68";
    hash = "sha256-lVfikUXULoG6Wksqt6iAAn6oATuVww2yAPz6LD/SOY4=";
  }) ++ lib.optional neologd (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-neologd";
    rev = "b0de4b90d7ddc3b837b40dc6974d6467daedc491";
    hash = "sha256-mS6GRvlAIyV0maZ+jbGUgZDPoS5OwnRGmJDTYiSw0FY=";
  }) ++ lib.optional personal-names (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-personal-names";
    rev = "1d30d6637127fd65a827dc8f52e40f1ed7af0e1d";
    hash = "sha256-mPzYWk4XpJCig3owVOwizTXws9zSJ5E3HdKHyGgQkXc=";
  }) ++ lib.optional place-names (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-place-names";
    rev = "8ddc00b0a8e0f3dc822a1008f0d62d1f59929025";
    hash = "sha256-nkzppZtNsSfgiC7kCTJkGfwqAfK/TYunz9Z5tE1N5s8=";
  }) ++ lib.optional skk-jisyo (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-skk-jisyo";
    rev = "5a996bfd369ee44ec681f86bb7880904e9171cdd";
    hash = "sha256-aL3lp+ZdVmcbQr7o7oGUcGPRhjBZtvrD+EC1FkWc1xA=";
  }) ++ lib.optional sudachidict (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-sudachidict";
    rev = "c109f062a6c80e52be4b96adbf4123404b2048d1";
    hash = "sha256-gU8bf0qiz/W7HEPhWBPC+GJzMmgqjcL4gzB80RdhEfY=";
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
    LC_ALL = "en_US.UTF-8";
  };

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
