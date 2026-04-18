final: prev:

let
  # https://discourse.nixos.org/t/4393/4
  # https://github.com/NixOS/nixpkgs/pull/382550
  tectonic-unwrapped = final.tectonic-unwrapped.overrideAttrs (
    finalAttrs: previousAttrs: {
      src = final.fetchFromGitHub {
        owner = "tectonic-typesetting";
        repo = "tectonic";
        rev = "5e6babe320fe8f041a513b050e34f633006abad0";
        hash = "sha256-6XSflGtBoGEaWBRJZLPj0MG0ie/4gE2LrgftKH9iP4Q=";
      };
      patches = [ ];
      cargoPatches = [ ];
      cargoHash = "sha256-jypBsWGEdwy9covhOjrjky/z7sOXmmqQt0aLpN8LScg=";
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
    buildCommand = builtins.replaceStrings
      [ "--web-bundle ${previousAttrs.passthru.bundleUrl}" ] [ "" ]
      previousAttrs.buildCommand;
  });
}
