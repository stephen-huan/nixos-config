{ pkgs, ... }:

{
  unfreePackages = [ pkgs.signal-desktop.passthru.apple-emoji ];
}
