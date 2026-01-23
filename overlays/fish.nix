final: prev:

let
  self = prev.fish;
  sh = "${final.busybox-sandbox-shell}/bin/sh";
in
{
  fish = self.overrideAttrs (previousAttrs: {
    # https://github.com/fish-shell/fish-shell/commit/7ca78e717892c56efa75b16a489075d6c30033c7
    # https://github.com/fish-shell/fish-shell/commit/e015956de721ef8e67f4d069ee46c28ef71f5744
    postPatch = previousAttrs.postPatch or "" + ''
      substituteInPlace \
        share/functions/__fish_posix_shell.fish \
        src/fork_exec/mod.rs \
        --replace-fail "/bin/sh" "${sh}"
    '';
  });
}
