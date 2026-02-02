{
  config,
  lib,
  pkgs,
  username,
  ...
}:

let
  cfg = config.modules.terminals.ghostty;
in
{
  options.modules.terminals.ghostty = {
    enable = lib.mkEnableOption "Ghostty terminal emulator";

    setAsDefault = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Set Ghostty as the default terminal emulator.";
    };

    theme = lib.mkOption {
      type = lib.types.str;
      default = "Catppuccin Mocha";
      description = "The Ghostty theme to use.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.ghostty
    ];

    environment.variables = lib.mkIf cfg.setAsDefault {
      COLORTERM = "truecolor";
      TERMINAL = "ghostty";
    };

    home-manager.users.${username} = {
      programs.ghostty = {
        enable = true;
        settings = {
          font-size = 11;
          theme = cfg.theme;
          window-decoration = false;
          unfocused-split-opacity = 0.1;
          window-padding-x = 15;
          window-padding-y = 15;
          clipboard-read = "allow";
          clipboard-write = "allow";
          copy-on-select = "clipboard";
          cursor-style-blink = true;
          auto-update-channel = "tip";
          quick-terminal-position = "center";
        };
      };
    };
  };
}
