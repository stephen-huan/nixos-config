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
      rev = "a4f4da32198f34838c1e25eb99b18c5cfb80ec39";
      sha256 = "sha256-/tlQcrpSlZktFr5aVtdNojpYja5oUJ1v5wk0xGFjAmM=";
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
