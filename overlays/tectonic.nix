final: prev:

let
  # https://discourse.nixos.org/t/4393/4
  # https://github.com/NixOS/nixpkgs/pull/382550
  tectonic-unwrapped = final.tectonic-unwrapped.overrideAttrs (
    finalAttrs: previousAttrs: {
      src = final.fetchFromGitHub {
        owner = "tectonic-typesetting";
        repo = "tectonic";
        rev = "09b1c14e89a8f2cf0c5b6d4bfb08fde07caa2725";
        hash = "sha256-POdR94xvEGZsSUQDuoQfzl8WUGIfXp9yRpHi6dIL6og=";
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
