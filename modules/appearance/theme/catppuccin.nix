{
  inputs,
  config,
  lib,
  username,
  ...
}:

let
  cfg = config.modules.appearance.theme.catppuccin;
in
{
  options.modules.appearance.theme.catppuccin = {
    enable = lib.mkEnableOption "Catppuccin theming";
    flavor = lib.mkOption {
      type = lib.types.enum [
        "latte"
        "frappe"
        "macchiato"
        "mocha"
      ];
      default = "mocha";
      description = "Catppuccin flavor (base theme color)";
    };
    accent = lib.mkOption {
      type = lib.types.enum [
        "rosewater"
        "flamingo"
        "pink"
        "mauve"
        "red"
        "maroon"
        "peach"
        "yellow"
        "green"
        "teal"
        "sky"
        "sapphire"
        "blue"
        "lavender"
      ];
      default = "lavender";
      description = "Catppuccin accent color for highlights";
    };
  };

  config = lib.mkIf cfg.enable {
    # System-level
    catppuccin.enable = true;
    catppuccin.flavor = cfg.flavor;
    catppuccin.accent = cfg.accent;

    # Home-Manager level
    home-manager.users.${username} = {
      imports = [ inputs.catppuccin.homeModules.catppuccin ];

      catppuccin.enable = true;
      catppuccin.flavor = cfg.flavor;
      catppuccin.accent = cfg.accent;
    };
  };
}
