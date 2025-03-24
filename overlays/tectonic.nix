final: prev:

let
  # https://discourse.nixos.org/t/4393/4
  # https://github.com/NixOS/nixpkgs/pull/382550
  tectonic-unwrapped = final.tectonic-unwrapped.overrideAttrs (
    finalAttrs: previousAttrs: {
      src = final.fetchFromGitHub {
        owner = "tectonic-typesetting";
        repo = "tectonic";
        rev = "c2ae25ff1facd9e9cce31b48944b867773f709ec";
        hash = "sha256-cDCJ1Tu2lA4KvN2EBUtT0MvMtkejd8YAoNRkNeoreEc=";
      };
      patches = [ ];
      cargoPatches = [ ];
      cargoHash = "sha256-dBthzRS+9wqKCwmo5cY/ynTdfIPK3QCsbZ2vAQ8q7aM=";
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
