{ self, ... }:
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
  # users.users.leonl.extraGroups = [ "docker" "libvirtd" ];
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

  ##### Hardware
  modules.hardware.nvidia.enable = true; # only enable on nvidia 20+ series

  ##### Appearance
  # modules.appearance.theme.catppuccin.enable = true;
  # modules.appearance.theme.catppuccin.flavor = "mocha";
  # modules.appearance.theme.catppuccin.accent = "mauve";
  modules.appearance.fonts.hurmit.enable = true;
  modules.appearance.fonts.jetbrains.enable = true;
  modules.appearance.fonts.victor.enable = true;
  modules.appearance.fonts.comic-sans.enable = true;
  modules.appearance.fonts.comic-shanns.enable = true;
  modules.appearance.desktops.niri.enable = true;
  modules.appearance.ui.dms.enable = true;
  modules.appearance.ui.dms.greeter.enable = true;
  modules.appearance.ui.icons.adwaita.enable = true;
  # modules.appearance.ui.cursor.catppuccin.enable = true;
  modules.appearance.ui.cursor.bibata.enable = true;
  modules.appearance.wallpapers.personal-walls.enable = true;

  ##### Shell & CLI
  modules.shell.zsh.enable = false;
  modules.shell.fish.enable = true;
  modules.cli.zoxide.enable = true;
  modules.cli.starship.enable = true;
  modules.cli.starship.palette = "nord";
  modules.cli.btop.enable = true;
  modules.cli.btop.theme = "nord";
  modules.cli.bat.enable = true;
  modules.cli.eza.enable = true;
  modules.cli.fd.enable = true;
  modules.cli.fzf.enable = true;
  modules.cli.jq.enable = true;
  modules.cli.ripgrep.enable = true;
  modules.cli.yazi.enable = true;
  modules.cli.zellij.enable = true;
  modules.cli.fastfetch.enable = true;

  ##### Dev
  modules.dev.cli.git.enable = true;
  modules.dev.cli.gh.enable = true;
  modules.dev.cli.lazygit.enable = true;
  modules.dev.editors.helix.enable = true;
  modules.dev.editors.neovim.enable = true;
  modules.dev.languages.go.enable = true;
  modules.dev.languages.python.enable = true;
  modules.dev.languages.web.enable = true;
  modules.dev.languages.sql.enable = true;
  modules.dev.languages.lua.enable = true;
  modules.dev.languages.markdown.enable = true;
  modules.dev.languages.toml.enable = true;
  modules.dev.languages.yaml.enable = true;
  modules.dev.languages.nix.enable = true;

  ##### Terminal
  modules.terminals.ghostty.enable = true;
  modules.terminals.ghostty.setAsDefault = true;
  modules.terminals.ghostty.theme = "Nord";
  modules.terminals.ghostty.font = "jetbrains";

  ##### Applications
  modules.programs.browsers.firefox.enable = true;
  modules.programs.productivity.obsidian.enable = true;
  modules.programs.file_managers.thunar.enable = true;
}
