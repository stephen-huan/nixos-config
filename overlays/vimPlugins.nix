final: prev:

let
  self = prev.vimPlugins;
  plugins = final.callPackage ../pkgs/applications/editors/vim/plugins {
    inherit (final.vimUtils) buildVimPlugin;
    inherit (final.neovimUtils) buildNeovimPlugin;
  };
in
{
  vimPlugins = self.extend plugins;
}
