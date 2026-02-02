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
    terminals.foot.enable = true;
    terminals.foot.setAsDefault = true;
    terminals.foot.theme = "tokyonight-storm";
    terminals.foot.font = "hurmit";
  };
}
