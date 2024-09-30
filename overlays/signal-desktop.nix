final: prev:

let
  self = prev.signal-desktop;
in
{
  # revert https://github.com/NixOS/nixpkgs/pull/337161
  signal-desktop = self.overrideAttrs (previousAttrs: {
    src = final.fetchurl {
      url = builtins.replaceStrings [ "7.25.0" ] [ "7.26.0" ]
        previousAttrs.src.url;
      hash = "sha256-FO9tkSW43qx3zzc+qUpCllsHxIKInE3gu1hMgXK7sxQ=";
    };

    nativeBuildInputs = previousAttrs.nativeBuildInputs ++ [ final.dpkg ];

    unpackPhase = ''
      runHook preUnpack

      dpkg-deb -x $src .

      runHook postUnpack
    '';

    installPhase =
      let
        lines = final.lib.splitString "\n" previousAttrs.installPhase;
        line =
          "# Copy the Noto Color Emoji PNGs into the ASAR contents. See `src`";
        index = final.lib.lists.findFirstIndex (x: x == line) null lines;
      in
      builtins.concatStringsSep "\n"
        ((final.lib.take index lines) ++ [ "runHook postInstall" ]);
  });
}
