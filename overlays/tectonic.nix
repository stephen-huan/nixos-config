final: prev:

let
  # https://discourse.nixos.org/t/4393/4
  # https://github.com/NixOS/nixpkgs/pull/382550
  tectonic-unwrapped = final.tectonic-unwrapped.overrideAttrs (
    finalAttrs: previousAttrs: {
      src = final.fetchFromGitHub {
        owner = "tectonic-typesetting";
        repo = "tectonic";
        rev = "825e11b71f7382da7c7e1a871e1590cf0cc9d7a2";
        hash = "sha256-/+d41poc/PPIvRP8XsPTNxLWiQWEgp5Xbrd+tKxan90=";
      };
      patches = [ ];
      cargoPatches = [ ];
      cargoHash = "sha256-yxwSH1zIM1z01+hW3uHU7XepwBgVMtrrngz5Du7GNck=";
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
