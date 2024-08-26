final: prev:

let
  self = prev.tectonic-unwrapped;
in
{
  # https://discourse.nixos.org/t/4393/4
  tectonic-unwrapped = self.override (previous: {
    rustPlatform = previous.rustPlatform // {
      buildRustPackage = args: previous.rustPlatform.buildRustPackage
        (args // {
          src = final.fetchFromGitHub {
            owner = "tectonic-typesetting";
            repo = "tectonic";
            rev = "19654bf152d602995da970f6164713953cffc2e6";
            sha256 = "sha256-3xfcumVLbURGR6Tdr6UAbMznCn7zNdIZDKCLqsaQksM=";
          };
          cargoHash = "sha256-641Ipqzq0twmomULZFakkhw4yPrXutCsf54/VdUTcpo=";
        });
    };
  });
}
