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
            rev = "d1ee37974a508c9fc093c408f109c85f9f287e96";
            sha256 = "sha256-z1LisQ/R7sL3XfRVhZ4oAEYqgjuFes6aTt89nKbMpls=";
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
