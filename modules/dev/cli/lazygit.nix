{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.modules.dev.cli.lazygit;
in
{
  options.modules.dev.cli.lazygit.enable = lib.mkEnableOption "Lazygit";

  config = lib.mkIf cfg.enable {
    # 1. Keep it global
    environment.systemPackages = [ pkgs.lazygit ];

    # 2. Bridge to Home Manager for the Catppuccin magic
    home-manager.users.${username}.programs.lazygit.enable = true;
  };
}
