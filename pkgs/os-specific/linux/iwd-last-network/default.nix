{ lib, stdenvNoCC, python3, black, isort, ruff }:

stdenvNoCC.mkDerivation {
  name = "iwd-last-network";
  src = ./iwd-last-network.py;

  sourceRoot = ".";
  unpackPhase = ''
    runHook preUnpack

    cp $src "$(stripHash "$src")"

    runHook postUnpack
  '';

  strictDeps = true;
  buildInputs = [ python3 ];
  preferLocalBuild = true;

  doCheck = true;
  nativeCheckInputs = [ black isort ruff ];
  checkPhase = ''
    runHook preCheck

    isort --check --diff --profile black .
    black --check --diff --exclude="" .
    ruff check .

    runHook postCheck
  '';

  installPhase = ''
    runHook preInstall

    install -Dm755 -T iwd-last-network.py $out/bin/iwd-last-network

    runHook postInstall
  '';

  meta = with lib; {
    description = "Return iwd's most recently connected network";
    license = licenses.unlicense;
    platforms = platforms.linux;
    maintainers = with maintainers; [ stephen-huan ];
  };
}
