final: prev:

let
  # https://discourse.nixos.org/t/4393/4
  tectonic-unwrapped = (
    final.tectonic-unwrapped.overrideAttrs { patches = [ ]; }
  ).override (previous: {
    rustPlatform = previous.rustPlatform // {
      buildRustPackage = args: previous.rustPlatform.buildRustPackage
        (args // {
          src = final.fetchFromGitHub {
            owner = "tectonic-typesetting";
            repo = "tectonic";
            rev = "ddca0b805c7a8c3edd93effc2b188a05f409161d";
            sha256 = "sha256-/hK3nRbrIq8X95REZonB/uVajc92bFMzRPauRTzYnh0=";
          };
          cargoHash = "sha256-xN9LPlS3zcN0qW950pq0SN7G45xS/Gpi0DuIrqsd9L4=";
          cargoPatches = [ ];
          checkFlags = args.checkFlags or [ ] ++ [
            # permission denied (os error 13) while making cache root
            "--skip=tests::no_segfault_after_failed_compilation"
          ];
        });
    };
  });
  self = prev.tectonic.override { inherit tectonic-unwrapped; };
in
{
  tectonic = self.overrideAttrs (previousAttrs: {
    buildCommand = builtins.replaceStrings [ "--web-bundle" ] [ "--bundle" ]
      previousAttrs.buildCommand;
  });
}
