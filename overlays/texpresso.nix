final: prev:

let
  self = prev.texpresso;
in
{
  # https://github.com/NixOS/nixpkgs/pull/509216
  texpresso = self.overrideAttrs (previousAttrs: {
    src = final.fetchFromGitHub {
      owner = "let-def";
      repo = "texpresso";
      rev = "a7c8050116ce5e61dbc684df127dfe2875bdbd4d";
      hash = "sha256-eGrk8PU3/+f8YRj7eLS8im/EOagLISpuc5LGTHfzwA0=";
    };
    nativeBuildInputs = previousAttrs.nativeBuildInputs ++ [
      final.fontconfig
      final.icu
      final.pkg-config
    ];
    buildFlags = [ "texpresso" "texpresso-xetex" ];
    postInstall = ''
      install -Dm0755 -t "$out/bin/" "build/texpresso-xetex"
    '';
  });
}
