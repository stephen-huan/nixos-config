final: prev:

let
  # https://discourse.nixos.org/t/4393/4
  # https://github.com/NixOS/nixpkgs/pull/382550
  tectonic-unwrapped = final.tectonic-unwrapped.overrideAttrs (
    finalAttrs: previousAttrs: {
      src = final.fetchFromGitHub {
        owner = "tectonic-typesetting";
        repo = "tectonic";
        rev = "d7f3275adf6b501fc21122a1873912e970bf52ba";
        hash = "sha256-4p5ZU1O75xcE4pDUs1xwZkFkxJ+g3Rm9LL5Cog96Sm8=";
      };
      patches = [ ];
      cargoPatches = [ ];
      cargoHash = "sha256-J3q0dtQ/qb/72b6A40TNYDIZvDrUSpxF3SFjhc+X0fw=";
      # pkgs/by-name/te/texpresso/package.nix
      cargoDeps = final.rustPlatform.fetchCargoVendor {
        inherit (finalAttrs) src;
        name = "${finalAttrs.pname}-${finalAttrs.version}";
        hash = finalAttrs.cargoHash;
        patches = finalAttrs.cargoPatches;
      };
      checkFlags = previousAttrs.checkFlags or [ ] ++ [
        # permission denied (os error 13) while making cache root
        "--skip=tests::no_segfault_after_failed_compilation"
      ];
    }
  );
  self = prev.tectonic.override { inherit tectonic-unwrapped; };
in
{
  tectonic = self.overrideAttrs (previousAttrs: {
    buildCommand = builtins.replaceStrings [ "--web-bundle" ] [ "--bundle" ]
      previousAttrs.buildCommand;
  });
}
