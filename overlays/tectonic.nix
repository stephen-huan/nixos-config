final: prev:

let
  # https://discourse.nixos.org/t/4393/4
  # https://github.com/NixOS/nixpkgs/pull/382550
  # https://github.com/NixOS/nixpkgs/pull/194475
  tectonic-unwrapped = (
    final.tectonic-unwrapped.overrideAttrs { patches = [ ]; }
  ).override (previous: {
    rustPlatform = previous.rustPlatform // rec {
      buildRustPackage = previous.rustPlatform.buildRustPackage // {
        __functor = _: args: previous.rustPlatform.buildRustPackage (args // {
          src = final.fetchFromGitHub {
            owner = "tectonic-typesetting";
            repo = "tectonic";
            rev = "c2ae25ff1facd9e9cce31b48944b867773f709ec";
            hash = "sha256-cDCJ1Tu2lA4KvN2EBUtT0MvMtkejd8YAoNRkNeoreEc=";
          };
          cargoHash = "sha256-dBthzRS+9wqKCwmo5cY/ynTdfIPK3QCsbZ2vAQ8q7aM=";
          cargoPatches = [ ];
          checkFlags = args.checkFlags or [ ] ++ [
            # permission denied (os error 13) while making cache root
            "--skip=tests::no_segfault_after_failed_compilation"
          ];
        });
        override = _: buildRustPackage;
      };
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
