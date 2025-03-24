final: prev:

let
  self = prev.texpresso;
in
{
  # https://github.com/NixOS/nixpkgs/pull/392621
  texpresso = self.overrideAttrs (previousAttrs: {
    src = final.fetchFromGitHub {
      owner = "let-def";
      repo = "texpresso";
      rev = "c42a5912f501f180984840fa8adf9ffc09c5ac13";
      sha256 = "sha256-T/vou7OcGtNoodCrznmjBLxg6ZAFDCjhpYgNyZaf44g=";
    };
    passthru = previousAttrs.passthru // {
      tectonic = previousAttrs.passthru.tectonic.overrideAttrs (super: {
        src = final.fetchFromGitHub {
          owner = "let-def";
          repo = "tectonic";
          rev = "bf124880d9901e12e2efe59df4818a921fb1398c";
          hash = "sha256-eKSfhYhe8PzOjQ3EJvy9e5DIUoekV8ahaDuhjwihCwI=";
          fetchSubmodules = true;
        };
        cargoPatches = [ ];
        patches = final.lib.drop (builtins.length super.cargoPatches)
          super.patches;
        cargoHash = "sha256-mX9DsucLbls1w0ULQ6kEHel/u1PZjQPcGZK3pjN7RVE=";
      });
    };
  });
}
