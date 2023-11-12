final: prev:

let
  self = prev.fishPlugins;
  plugins = "pkgs/shells/fish/plugins";
in
{
  fishPlugins = self.overrideScope (_: _: {
    fish-command-timer = self.callPackage
      ../${plugins}/fish-command-timer.nix
      { };
  });
}
