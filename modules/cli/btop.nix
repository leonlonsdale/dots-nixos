{
  config,
  lib,
  pkgs,
  username,
  ...
}:

let
  cfg = config.modules.cli.btop;
in
{
  options.modules.cli.btop = {
    enable = lib.mkEnableOption "btop resource monitor";

    theme = lib.mkOption {
      type = lib.types.str;
      default = "catppuccin_mocha";
      description = "The btop theme to use (filename without extension).";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.btop ];

    home-manager.users.${username}.programs.btop = {
      enable = true;
      settings = {
        color_theme = cfg.theme;
        theme_background = false;
        vim_keys = true;
        update_ms = 1000;
        rounded_corners = true;
        graph_symbol = "braille";
      };
    };
  };
}
