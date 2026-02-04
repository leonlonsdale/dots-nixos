{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.appearance.ui.cursor;
  enabledTheme = lib.findFirst (x: x.enable) null (lib.attrValues cfg);
in
{
  options.modules.appearance.ui.cursor = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "cursor theme";
          name = lib.mkOption { type = lib.types.str; };
          package = lib.mkOption { type = lib.types.package; };
          size = lib.mkOption {
            type = lib.types.int;
            default = 24;
          };
        };
      }
    );
  };

  config = {
    modules.appearance.ui.cursor = {
      catppuccin = {
        name = lib.mkDefault "catppuccin-mocha-mauve-cursors";
        package = lib.mkDefault pkgs.catppuccin-cursors.mochaMauve;
      };
      bibata = {
        name = lib.mkDefault "Bibata-Modern-Classic";
        package = lib.mkDefault pkgs.bibata-cursors;
      };
      nord = {
        name = lib.mkDefault "Nordic-Cursors";
        package = lib.mkDefault pkgs.nordic;
      };

      # --- Modern & Minimalist ---
      phinger = {
        name = lib.mkDefault "phinger-cursors-light";
        package = lib.mkDefault pkgs.phinger-cursors;
      };
      google = {
        name = lib.mkDefault "GoogleDot-Blue";
        package = lib.mkDefault pkgs.google-cursor;
      };
      capitaine = {
        name = lib.mkDefault "capitaine-cursors";
        package = lib.mkDefault pkgs.capitaine-cursors;
      };

      # --- High Contrast / Unique ---
      breeze = {
        name = lib.mkDefault "breeze_cursors";
        package = lib.mkDefault pkgs.kdePackages.breeze-icons;
      };
      volantes = {
        name = lib.mkDefault "volantes_cursors";
        package = lib.mkDefault pkgs.volantes-cursors;
      };
    };

    environment.systemPackages = lib.mapAttrsToList (name: value: value.package) (
      lib.filterAttrs (name: value: value.enable) cfg
    );

    environment.sessionVariables = lib.mkIf (enabledTheme != null) {
      XCURSOR_THEME = enabledTheme.name;
      XCURSOR_SIZE = toString enabledTheme.size;
    };
  };
}
