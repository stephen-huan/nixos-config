final: prev:

let
  self = prev.fishPlugins;
in
{
  fishPlugins = self.overrideScope (_: _: {
    fish-command-timer = self.callPackage
      ../pkgs/shells/fish/plugins/fish-command-timer.nix
      { };
  });
}
