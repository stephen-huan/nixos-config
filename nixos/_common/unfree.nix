{ pkgs, ... }:

{
  unfreePackages = [
    "firefox-esr-140-bin-unwrapped"
    pkgs.signal-desktop.passthru.apple-emoji
  ];
  insecurePackages = [
    "firefox-esr-140-bin-unwrapped"
  ];
}
