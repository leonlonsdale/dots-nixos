{ self, ... }:
{
  imports = [
    /etc/nixos/hardware-configuration.nix
    (self + "/modules")
  ];

  modules = {
    shell.zsh.enable = true;
    cli.starship.enable = true;
    cli.starship.palette = "catppuccin_mocha";

    dev.cli.git.enable = true;
    dev.editors.helix.enable = true;
  };
}
