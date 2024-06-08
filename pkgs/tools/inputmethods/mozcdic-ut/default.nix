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
  version = "20240420";

  srcs = [
    mozc.src
    (fetchFromGitHub rec {
      name = repo;
      owner = "utuhiro78";
      repo = "merge-ut-dictionaries";
      rev = "7d8a3f9df79e4bf38ab973a64dbc2cd562f2306e";
      hash = "sha256-szQHVW028DSxf5hHGV3G1wqsJVLqtrrfAV2DpVeM7eg=";
    })
    (fetchurl {
      url = "https://dumps.wikimedia.org/jawiki/${version}/jawiki-${version}-all-titles-in-ns0.gz";
      hash = "sha256-bp01U7d24msbpbp/Ubvu6xsFQOM1+b0IsuAdgF0opbc=";
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
    rev = "776463e642a441954a6e37bb3b349ee81c7a15c9";
    hash = "sha256-Sl/1r+iNipHFUVEpHFrnvvnDUXimnuB8LGNds+vVuMI=";
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
    rev = "adaaaf903f9609a52cafc63aea7a58fc6e00cc64";
    hash = "sha256-SmiM+W2RRQW4CwuIYOytLLE6JfdqRDuC52CDKkBZbwY=";
  }) ++ lib.optional place-names (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-place-names";
    rev = "2dfabeab535c90308e0d25bdd9b95de90cfc904e";
    hash = "sha256-BPVJqWbdvBTjKR5u4GR+8m0z8Jp1j5wAlgVrjklL9RY=";
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
    ./mozc-id.patch
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
