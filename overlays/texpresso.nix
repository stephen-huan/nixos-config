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
      rev = "6073a336dd67e5d4fde0ded4b33580920de7f69d";
      sha256 = "sha256-J+1OtrLUP9P3diUcndlQnXp70dfjAfc39ZYcIVr5/hI=";
    };
    passthru = previousAttrs.passthru // {
      tectonic = previousAttrs.passthru.tectonic.overrideAttrs (super: {
        src = final.fetchFromGitHub {
          owner = "let-def";
          repo = "tectonic";
          rev = "be0a9543600ab3a98f6ae6c37047522c09c2a02e";
          hash = "sha256-jpAVG1xzpAh9Y6d3uSRo6OHuLWwGnkU8PraZGjqmNY4=";
          fetchSubmodules = true;
        };
        cargoPatches = [ ];
        patches = final.lib.drop ((builtins.length super.cargoPatches) + 2)
          super.patches;
        cargoHash = "sha256-mX9DsucLbls1w0ULQ6kEHel/u1PZjQPcGZK3pjN7RVE=";
      });
    };
  });
}
