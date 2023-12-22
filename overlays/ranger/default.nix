final: prev:

let
  self = prev.ranger;
in
{
  ranger = self.overrideAttrs {
    patches = [ ./lazy-nix-store.patch ];
  };
}
