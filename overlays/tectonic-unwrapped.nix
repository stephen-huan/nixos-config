final: prev:

let
  self = prev.tectonic-unwrapped.overrideAttrs { patches = [ ]; };
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
            rev = "51e179f7428cf00669ae4751ce59f10b4accdd05";
            sha256 = "sha256-Tml+aE0TjL7Pblh5LxyG2rPSXj9YzWccmu4R8yiYi4I=";
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
}
