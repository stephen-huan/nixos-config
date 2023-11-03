{ self, ... }:

{
  nixpkgs = {
    overlays = builtins.attrValues self.overlays;
    config = {
      permittedInsecurePackages = [ "zotero-6.0.27" ];
    };
  };
}
