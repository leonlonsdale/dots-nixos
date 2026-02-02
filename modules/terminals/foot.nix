{
  config,
  lib,
  pkgs,
  username,
  ...
}:

let
  cfg = config.modules.terminals.foot;
  fnt = config.modules.appearance.fonts;
in
{
  options.modules.terminals.foot = {
    enable = lib.mkEnableOption "foot terminal";
    setAsDefault = lib.mkEnableOption "set foot as default terminal";
    # theme = lib.mkOption {
    #   type = lib.types.str;
    #   default = "tokyonight-storm";
    # };
    font = lib.mkOption {
      type = lib.types.str;
      default = "monospace";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} = {
      home.sessionVariables = lib.mkIf cfg.setAsDefault {
        TERMINAL = "foot";
      };

      programs.foot = {
        enable = true;

        settings = {
          main = {
            term = "xterm-256color";
            font = "${if cfg.font == "monospace" then "monospace" else fnt.${cfg.font}.prettyName}:size=11";
            dpi-aware = "yes";
            # include = "${pkgs.foot.themes}/share/foot/themes/${cfg.theme}";
            pad = "15x15";
          };

          mouse = {
            hide-when-typing = "yes";
          };

          csd = {
            size = 0;
            preferred = "none";
          };
        };
      };
    };
  };
}
