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
    ##### Appearance
    appearance.fonts.hurmit.enable = true;
    appearance.fonts.jetbrains.enable = true;
    appearance.fonts.victor.enable = true;

    ##### Shell & CLI
    shell.zsh.enable = true;

    cli.starship.enable = true;
    cli.starship.palette = "tokyonight";
    cli.btop.enable = true;
    cli.btop.theme = "tokyo-night";

    ##### Dev
    dev.cli.git.enable = true;
    dev.editors.helix.enable = true;

    ##### Terminal
    terminals.foot.enable = true;
    terminals.foot.setAsDefault = true;
    terminals.foot.theme = "tokyonight-storm";
    terminals.foot.font = "hurmit";
  };
}
