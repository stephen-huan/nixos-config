{
  pkgs = self: super: import ../pkgs/top-level { pkgs = self; };
  maintainers = import ./maintainers.nix;
}
