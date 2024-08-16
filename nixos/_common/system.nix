{ self, ... }:

{
  system = {
    # nixos-version --configuration-revision
    configurationRevision = self.rev or "dirty";

    stateVersion = "23.11";
  };
}
