{
  self,
  ...
}:
{
  # ============================================================================
  # HOST-SPECIFIC CONFIGURATION
  # ============================================================================
  # NOTE: Basic user settings (shell, home-manager, stateVersion) are inherited
  # from commonConfig.nix.
  #
  # To OVERRIDE or CLEAR the default extraGroups (wheel, networkmanager, etc.):
  # users.users.${username}.extraGroups = lib.mkForce [ "customgroup" ];
  #
  # OR to remove all groups:
  # users.users.${username}.extraGroups = lib.mkForce [ ];
  #
  # To APPEND additional groups:
  # users.users.${username}.extraGroups = [ "docker" "libvirtd" ];
  # ============================================================================

  imports = [
    /etc/nixos/hardware-configuration.nix
    (self + "/modules")
  ];

  # Security / Nix power settings
  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  # ============================================================================
  # FEATURE TOGGLES (MODULES)
  # ============================================================================

  ##### Appearance
  modules.appearance.theme.catppuccin.enable = true;
  modules.appearance.theme.catppuccin.flavor = "mocha";
  modules.appearance.theme.catppuccin.accent = "mauve";
  modules.appearance.desktops.kdeplasma.enable = true;
  modules.appearance.wallpapers.personal-walls.enable = true;

  ##### Shell & CLI
  modules.shell.zsh.enable = true;
  modules.cli.starship.enable = true;
  modules.cli.yazi.enable = true;

  ##### Terminal
  modules.terminals.kitty.enable = true;
  modules.terminals.kitty.setAsDefault = true;
  # modules.terminals.kitty.theme = "tokyonight-storm";
  modules.terminals.kitty.font = "jetbrains";

  ##### Applications
  modules.programs.browsers.firefox.enable = true;
}
