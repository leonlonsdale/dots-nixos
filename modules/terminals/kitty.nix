{
  config,
  lib,
  pkgs,
  username,
  ...
}:

let
  cfg = config.modules.terminals.kitty;
  fnt = config.modules.appearance.fonts;

  enabledKeys = lib.attrNames (lib.filterAttrs (n: v: v.enable) fnt);
in
{
  options.modules.terminals.kitty = {
    enable = lib.mkEnableOption "Kitty terminal emulator";

    font = lib.mkOption {
      type = lib.types.str;
      default = "monospace";
      description = "Selected font key. Currently enabled: ${lib.concatStringsSep ", " enabledKeys}";
    };

    setAsDefault = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    theme = lib.mkOption {
      type = lib.types.str;
      default = "Catppuccin-Mocha";
      description = "The Kitty theme to use.";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.font == "monospace" || (fnt ? ${cfg.font} && fnt.${cfg.font}.enable);
        message = "Font '${cfg.font}' is not enabled in modules.appearance.fonts!";
      }
    ];

    environment.variables = lib.mkIf cfg.setAsDefault {
      TERMINAL = "kitty";
    };

    home-manager.users.${username}.programs.kitty = {
      enable = true;
      themeFile = cfg.theme;
      font = {
        name = if cfg.font == "monospace" then "monospace" else fnt.${cfg.font}.prettyName;
        size = 11;
      };
      settings = {
        scrollback_lines = 3000;
        cursor_underline_thickness = "4.0";
        cursor_trail = 10;
        cursor_trail_decay = "0.15 0.4";
        cursor_trail_start_threshold = 2;
        hide_window_decorations = "yes";
        window_padding_width = 10;
        confirm_os_window_close = 0;
        input_delay = 3;
        disable_ligatures = "never";
      };
    };
  };
}
