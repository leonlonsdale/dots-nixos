{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.modules.cli.eza;
in
{
  options.modules.cli.eza.enable = lib.mkEnableOption "eza (modern ls replacement)";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.eza ];

    home-manager.users.${username} = {
      programs.eza = {
        enable = true;
        icons = "auto";
        git = true;
      };

      # programs.eza.catppuccin.enable = true;
    };
  };
}
