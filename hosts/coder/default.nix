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
    appearance.fonts.hurmit.enable = true;
    appearance.fonts.jetbrains.enable = true;
    appearance.fonts.victor.enable = true;
    appearance.desktops.niri.enable = true;
    appearance.ui.dms.enable = true;
    appearance.ui.dms.greeter.enable = true;
    appearance.ui.icons.qt.enable = true;
    appearance.wallpapers.personal-walls.enable = true;

    ##### Shell & CLI
    shell.zsh.enable = true;

    cli.starship.enable = true;
    # cli.starship.palette = "tokyonight";
    cli.btop.enable = true;
    # cli.btop.theme = "tokyo-night";
    cli.bat.enable = true;
    cli.eza.enable = true;
    cli.fd.enable = true;
    cli.fzf.enable = true;
    cli.jq.enable = true;
    cli.ripgrep.enable = true;
    cli.yazi.enable = true;
    cli.zellij.enable = true;

    ##### Dev
    dev.cli.git.enable = true;
    dev.cli.gh.enable = true;
    dev.cli.lazygit.enable = true;
    dev.editors.helix.enable = true;
    dev.languages.go.enable = true;
    dev.languages.python.enable = true;
    dev.languages.web.enable = true;
    dev.languages.sql.enable = true;
    dev.languages.lua.enable = true;
    dev.languages.markdown.enable = true;
    dev.languages.toml.enable = true;
    dev.languages.yaml.enable = true;
    dev.languages.nix.enable = true;

    ##### Terminal
    terminals.kitty.enable = true;
    terminals.kitty.setAsDefault = true;
    # terminals.kitty.theme = "tokyonight-storm";
    terminals.kitty.font = "jetbrains";

    ##### Applications

    programs.browsers.firefox.enable = true;
    programs.productivity.obsidian.enable = true;
  };
}
