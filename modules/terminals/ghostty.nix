{
  config,
  lib,
  pkgs,
  username,
  ...
}:

let
  cfg = config.modules.terminals.ghostty;
  fnt = config.modules.appearance.fonts;

  # Get a list of fonts that are actually ENABLED for the help description
  enabledKeys = lib.attrNames (lib.filterAttrs (n: v: v.enable) fnt);
in
{
  options.modules.terminals.ghostty = {
    enable = lib.mkEnableOption "Ghostty terminal emulator";

    font = lib.mkOption {
      type = lib.types.str;
      default = "monospace";
      description = "Selected font key. Currently enabled: ${lib.concatStringsSep ", " enabledKeys}";
    };

    setAsDefault = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Set Ghostty as the default terminal emulator.";
    };

    # theme = lib.mkOption {
    #   type = lib.types.str;
    #   default = "Catppuccin Mocha";
    #   description = "The Ghostty theme to use.";
    # };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.font == "monospace" || (fnt ? ${cfg.font} && fnt.${cfg.font}.enable);
        message = "Font '${cfg.font}' is not enabled in modules.appearance.fonts! Enabled fonts are: ${lib.concatStringsSep ", " enabledKeys}";
      }
    ];

    environment.systemPackages = [
      pkgs.ghostty
    ];

    environment.variables = lib.mkIf cfg.setAsDefault {
      TERMINAL = "ghostty";
    };

    home-manager.users.${username} = {
      programs.ghostty = {
        enable = true;
        settings = {
          font-family = if cfg.font == "monospace" then "monospace" else fnt.${cfg.font}.prettyName;
          font-size = 12;
          # theme = cfg.theme;
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
