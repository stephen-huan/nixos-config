{ lib, stdenvNoCC, python3, black, isort, ruff, pyright }:

stdenvNoCC.mkDerivation {
  name = "iwd-last-network";
  src = ./src;

  strictDeps = true;
  buildInputs = [ python3 ];
  preferLocalBuild = true;

  doCheck = true;
  nativeCheckInputs = [ black isort ruff pyright ];
  checkPhase = ''
    runHook preCheck

    isort --check --diff --profile black .
    black --check --diff --exclude="" .
    ruff check .
    pyright .

    runHook postCheck
  '';

  installPhase = ''
    runHook preInstall

    install -Dm755 iwd-last-network.py -T $out/bin/iwd-last-network

    runHook postInstall
  '';

  meta = with lib; {
    description = "Return iwd's most recently connected network";
    license = licenses.unlicense;
    platforms = platforms.linux;
    mainProgram = "iwd-last-network";
    maintainers = with maintainers; [ stephen-huan ];
  };
}
