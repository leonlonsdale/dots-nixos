{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.modules.cli.eza;

  # Detection for active shell modules to apply aliases
  zshEnabled = config.modules.shell.zsh.enable or false;
  fishEnabled = config.modules.shell.fish.enable or false;
  bashEnabled = config.modules.shell.bash.enable or false;

  # Customised aliases to be shared across shells
  ezaAliases = {
    ls = "eza --icons --color=always --group-directories-first";
    ll = "eza -l --icons --color=always --group-directories-first";
    la = "eza -la --icons --color=always --group-directories-first";
  };
in
{
  options.modules.cli.eza.enable = lib.mkEnableOption "eza (modern ls replacement)";

  config = lib.mkIf cfg.enable {
    # System-level package installation
    environment.systemPackages = [ pkgs.eza ];

    home-manager.users.${username} = {
      programs.eza = {
        enable = true;
        icons = "auto";
        git = true;
        # We handle aliases manually below for finer control across different shells
        enableZshIntegration = false;
        enableBashIntegration = false;
        enableFishIntegration = false;
      };

      # Apply standardised aliases only to shells that are currently enabled
      programs.zsh.shellAliases = lib.mkIf zshEnabled ezaAliases;
      programs.fish.shellAliases = lib.mkIf fishEnabled ezaAliases;
      programs.bash.shellAliases = lib.mkIf bashEnabled ezaAliases;

      # programs.eza.catppuccin.enable = true;
    };
  };
}
