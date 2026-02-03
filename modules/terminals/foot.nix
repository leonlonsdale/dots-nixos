{
  config,
  lib,
  username,
  ...
}:

let
  cfg = config.modules.terminals.foot;
  fnt = config.modules.appearance.fonts;

  enabledKeys = lib.attrNames (lib.filterAttrs (n: v: v.enable) fnt);
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
      description = "Selected font key. Currently enabled: ${lib.concatStringsSep ", " enabledKeys}";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.font == "monospace" || (fnt ? ${cfg.font} && fnt.${cfg.font}.enable);
        message = "Font '${cfg.font}' is not enabled in modules.appearance.fonts!";
      }
    ];

    home-manager.users.${username} = {
      home.sessionVariables = lib.mkIf cfg.setAsDefault {
        TERMINAL = "foot";
      };

      programs.foot = {
        enable = true;

        settings = {
          main = {
            term = "xterm-256color";
            font = "${if cfg.font == "monospace" then "monospace" else fnt.${cfg.font}.prettyName}:size=12";
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
