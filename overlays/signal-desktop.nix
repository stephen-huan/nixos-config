final: prev:

let
  self = prev.signal-desktop;
in
{
  # revert https://github.com/NixOS/nixpkgs/pull/337161
  signal-desktop = self.overrideAttrs (previousAttrs: {
    src = final.fetchurl {
      url = builtins.replaceStrings [ self.version ] [ "7.46.0" ]
        previousAttrs.src.url;
      hash = "sha256-busAYYdxrXhezvqm9p5lbeIG5OMQUWg4RKu2p7ME0D4=";
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
