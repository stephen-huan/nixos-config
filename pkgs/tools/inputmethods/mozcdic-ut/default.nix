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
  version = "20240620";

  srcs = [
    mozc.src
    (fetchFromGitHub rec {
      name = repo;
      owner = "utuhiro78";
      repo = "merge-ut-dictionaries";
      rev = "23ae870ee0f8e4d115019fcaf1a8b74d204a9f89";
      hash = "sha256-kHhLMUnTS1K1uzkAuh8ItY6t7d4Xn6pXyn3Xft5Di4k=";
    })
    (fetchurl {
      url = "https://dumps.wikimedia.org/jawiki/${version}/jawiki-${version}-all-titles-in-ns0.gz";
      hash = "sha256-uL3Yro7mXLM+9b7ktUPQMZUPCTt275FsFd6JAgZtjZY=";
    })
  ] ++ lib.optional alt-cannadic (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-alt-cannadic";
    rev = "9e71156adf8cbaf148fe76bc12539f55b461e163";
    hash = "sha256-JslI5hY6uZgIC4iGX4+oVGcS2PKJefadFjy4iCnH3m8=";
  }) ++ lib.optional edict (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-edict2";
    rev = "38f7f74726d36b4ece85adadd3739b6177592108";
    hash = "sha256-Ckvvc/vTAHOqVyViEqwY6KnKx5zBM5zHRNX65mRVJ/8=";
  }) ++ lib.optional jawiki (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-jawiki";
    rev = "daab02bed062e4a3723a07d875194d436324df2a";
    hash = "sha256-utsX2akMmYF6RwntrIjyQcpFS650Udr6FZ0zy7hTqss=";
  }) ++ lib.optional neologd (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-neologd";
    rev = "65370a0efae204f3d9071f46ec56f72e8cf5508a";
    hash = "sha256-/mSwxazEw9YuHi8boFzuGWG94zNUc0qB/+fHqgw1XcY=";
  }) ++ lib.optional personal-names (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-personal-names";
    rev = "e1049584984ac9376685937661ae18c968e25c48";
    hash = "sha256-yiZooHKB8+eNyt1ZaPjcm3gLCExYQqB6lI02GR5utto=";
  }) ++ lib.optional place-names (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-place-names";
    rev = "1e45b1d5781e46c3d99d285711a0fb964b223a67";
    hash = "sha256-Ilf/V9cYVx75lsdHBi38M8qPGjDOpoUDcQ20QDfxZ8Q=";
  }) ++ lib.optional skk-jisyo (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-skk-jisyo";
    rev = "e1f26b891ea80f52f846791959fa8e4acf36fa99";
    hash = "sha256-o5EvAnv6Iha0RiHQ0BjqrkHHSlmSTs0dGX0zbGAAKTc=";
  }) ++ lib.optional sudachidict (fetchFromGitHub rec {
    name = repo;
    owner = "utuhiro78";
    repo = "mozcdic-ut-sudachidict";
    rev = "f25afb4be556a5549f41cd0032fe3e6c4ad6e655";
    hash = "sha256-jpiurgcStGPfM+p3/ITeMB2+3lqfk9A5oAJeHWShPyw=";
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
  nativeBuildInputs = [ ruby ];

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
