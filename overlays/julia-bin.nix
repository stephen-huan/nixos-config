final: prev:

let
  self = prev.julia-bin;
in
{
  # temporary workaround for build failure
  # https://hydra.nixos.org/build/275522253
  julia-bin = self.overrideAttrs {
    doInstallCheck = false;
  };
}
