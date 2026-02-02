{
  self,
  stateVersion,
  hostname,
  ...
}:
{
  imports = [
    /etc/nixos/hardware-configuration.nix
    (self + "/modules")
    ./user.nix
    ./home.nix
  ];

  networking.hostName = hostname;
  system.stateVersion = stateVersion;

  modules = {
    shell.zsh.enable = true;
    cli.starship.enable = true;
    cli.starship.palette = "catppuccin_mocha";

    dev.cli.git.enable = true;
    dev.editors.helix.enable = true;

    terminals.ghostty.enable = true;
    terminals.ghostty.setAsDefault = true;
    terminals.ghostty.theme = "Catppuccin Mocha";
  };
}
