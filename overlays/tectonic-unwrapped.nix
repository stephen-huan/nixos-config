final: prev:

let
  self = prev.tectonic-unwrapped;
in
{
  # https://discourse.nixos.org/t/4393/4
  tectonic-unwrapped = final.callPackage self.override {
    rustPlatform = final.rustPlatform // {
      buildRustPackage = args: final.rustPlatform.buildRustPackage (args // {
        src = final.fetchFromGitHub {
          owner = "tectonic-typesetting";
          repo = "tectonic";
          rev = "78fd97716ee111861bd981a45e6816589d16f504";
          sha256 = "sha256-pKx2fzBllkv3fzUfhv9qKlPqD4JKdEN74+gsLbmwZ/o=";
        };
        cargoHash = "sha256-BcVepSoFogh/OU0DoQNnT8X9bNc74rMDT+3zelmfwkY=";
        # https://github.com/NixOS/nixpkgs/pull/291770
        buildFeatures = [ "external-harfbuzz" ];
      });
    };
  };
}
