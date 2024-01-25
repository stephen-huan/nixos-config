{ lib, stdenvNoCC, fetchzip }:

let
  name = "kanji-stroke-order-font";
in
stdenvNoCC.mkDerivation {
  pname = name;
  version = "4.004";

  src = fetchzip {
    # https://github.com/NixOS/nixpkgs/issues/60157
    url = "https://drive.google.com/uc?export=download&id=1snpD-IQmT6fGGQjEePHdDzE2aiwuKrz4#${name}.zip";
    hash = "sha256-wQpurDS6APnpNMbMHofwW/UKeBF8FXeiCVx4wAOeRoE=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 *.ttf -t $out/share/fonts/truetype
    install -Dm644 *.txt -t $out/share/doc/${name}
    install -Dm644 *.pdf -t $out/share/doc/${name}

    runHook postInstall
  '';

  meta = with lib; {
    description = "Japanese font that shows kanji stroke order";
    homepage = "https://www.nihilist.org.uk/";
    license = licenses.bsd3;
    maintainers = with maintainers; [ stephen-huan ];
  };
}
