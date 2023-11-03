{ specialArgs, ... }:

{
  # nixos-version --configuration-revision
  system.configurationRevision = specialArgs.self.rev or "dirty";
}
