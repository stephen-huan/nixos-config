{ specialArgs, ... }:

{
  system = {
    # nixos-version --configuration-revision
    configurationRevision = specialArgs.self.rev or "dirty";

    stateVersion = "23.11";
  };
}
