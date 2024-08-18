{ lib
, formats
, stdenvNoCC
, fetchFromGitLab
, libsForQt5
, themeConfig ? null
}:

let
  user-cfg = (formats.ini { }).generate "theme.conf.user" themeConfig;
in

stdenvNoCC.mkDerivation {
  pname = "simplicity-sddm-theme";
  version = "1.0-2024-08-18";

  src = fetchFromGitLab {
    owner = "stephenhuan";
    repo = "simplicity-sddm-theme";
    rev = "715421eff3239408d9e6aab7fce0b8a02b7b5e92";
    hash = "sha256-PRnG4EUKkm2lMSOZxeNV87jcD0xfN8fxXDyAbjoJr8E=";
  };

  propagatedBuildInputs = with libsForQt5; [ qtquickcontrols2 ];

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
