final: prev:

let
  self = prev.fish;
  sh = "${final.busybox-sandbox-shell}/bin/sh";
in
{
  fish = self.overrideAttrs (previousAttrs: {
    # https://github.com/fish-shell/fish-shell/commit/e015956de721ef8e67f4d069ee46c28ef71f5744
    postPatch = previousAttrs.postPatch or "" + ''
      substituteInPlace \
        share/functions/__fish_apropos.fish \
        share/functions/__fish_config_interactive.fish \
        share/functions/fish_git_prompt.fish \
        share/functions/help.fish \
        --replace-fail "/bin/sh" "${sh}"
    '';
  });
}
