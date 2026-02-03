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
    appearance.theme.catppuccin.enable = true;
    appearance.theme.catppuccin.flavor = "mocha";
    appearance.theme.catppuccin.accent = "mauve";
    appearance.desktops.kdeplasma.enable = true;
    appearance.wallpapers.personal-walls.enable = true;

    ##### Shell & CLI
    shell.zsh.enable = true;
    cli.starship.enable = true;
    cli.yazi.enable = true;

    ##### Terminal
    terminals.kitty.enable = true;
    terminals.kitty.setAsDefault = true;
    # terminals.kitty.theme = "tokyonight-storm";
    terminals.kitty.font = "jetbrains";

    ##### Applications

    programs.browsers.firefox.enable = true;
  };
}
