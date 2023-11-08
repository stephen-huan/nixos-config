{ lib, stdenv, python3, black, isort, ruff }:

stdenv.mkDerivation {
  name = "iwd-last-network";
  src = ./iwd-last-network.py;

  unpackCmd = ''
    mkdir iwd-last-network
    cp $src ./iwd-last-network/iwd-last-network.py
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

    mkdir -p $out/bin
    chmod +x iwd-last-network.py
    cp iwd-last-network.py $out/bin/iwd-last-network

    runHook postInstall
  '';

  meta = with lib; {
    description = "Return iwd's most recently connected network";
    license = licenses.unlicense;
    maintainers = with maintainers; [ stephen-huan ];
  };
}
