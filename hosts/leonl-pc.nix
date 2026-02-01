{ self, ... }:
{
  imports = [
    /etc/nixos/hardware-configuration.nix
    (self + "/modules")
  ];

  modules = {
    shell.zsh.enable = true;
    dev = {
      cli.git.enable = true;
      editors.helix.enable = true;
    };
  };
}
