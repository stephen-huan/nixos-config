{
  pkgs = final: prev: import ../pkgs/top-level { pkgs = final; };
  maintainers = import ./maintainers.nix;
}
