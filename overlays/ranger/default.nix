final: prev:

{
  ranger = prev.ranger.overrideAttrs {
    patches = [ ./lazy-nix-store.patch ];
  };
}
