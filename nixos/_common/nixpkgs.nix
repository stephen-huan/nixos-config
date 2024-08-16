{ self, ... }:

{
  nixpkgs = {
    overlays = builtins.attrValues self.overlays;
    flake = {
      setNixPath = false;
      setFlakeRegistry = false;
    };
  };
}
