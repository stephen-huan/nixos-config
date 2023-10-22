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
    isort --check --diff --profile black .
    black --check --diff --exclude="" .
    ruff check .
  '';

  installPhase = ''
    mkdir -p $out/bin
    chmod +x ./iwd-last-network.py
    cp ./iwd-last-network.py $out/bin/iwd-last-network
  '';

  meta = {
    description = "Return iwd's most recently connected network";
    license = lib.licenses.unlicense;
    maintainers = [ lib.maintainers.stephen-huan ];
  };
}
