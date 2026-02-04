{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.appearance.ui.icons;
in
{
  options.modules.appearance.ui.icons = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "icon theme";
          name = lib.mkOption { type = lib.types.str; };
          package = lib.mkOption { type = lib.types.package; };
        };
      }
    );
  };

  config = {
    modules.appearance.ui.icons = {
      adwaita = {
        name = lib.mkDefault "Adwaita";
        package = lib.mkDefault pkgs.adwaita-icon-theme;
      };
      papirus = {
        name = lib.mkDefault "Papirus-Dark";
        package = lib.mkDefault pkgs.papirus-icon-theme;
      };
    };

    environment.systemPackages = lib.mapAttrsToList (name: value: value.package) (
      lib.filterAttrs (name: value: value.enable) cfg
    );
  };
}
