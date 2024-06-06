{ pkgs, ... }:

{
  xdg.configFile."python_keyring/keyringrc.cfg" = {
    source = (pkgs.formats.ini { }).generate "keyringrc.cfg" {
      backend.default-keyring = "keyring_pass.PasswordStoreBackend";
    };
  };
}
