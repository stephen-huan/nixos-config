{ lib
, formats
, stdenvNoCC
, fetchFromGitLab
, themeConfig ? null
}:

let
  user-cfg = (formats.ini { }).generate "theme.conf.user" themeConfig;
in

stdenvNoCC.mkDerivation {
  pname = "simplicity-sddm-theme";
  version = "25.09-2025-10-07";

  src = fetchFromGitLab {
    owner = "stephenhuan";
    repo = "simplicity-sddm-theme";
    rev = "81a50cd29a4806a2d9c7dca7caafb79c89f1834e";
    hash = "sha256-JnDrzYzPjDr5QRjPGx8bF3v8kt541qCn0wfnh1BrxiE=";
  };

  dontWrapQtApps = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/sddm/themes"
    cp -r simplicity/ "$out/share/sddm/themes/simplicity"
  '' + (lib.optionalString (lib.isAttrs themeConfig) ''
    ln -sf ${user-cfg} $out/share/sddm/themes/simplicity/theme.conf.user
  '') + ''
    runHook postInstall
  '';

  meta = with lib; {
    description = "Simple SDDM theme";
    homepage = "https://gitlab.com/isseigx/simplicity-sddm-theme";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ stephen-huan ];
  };
}
