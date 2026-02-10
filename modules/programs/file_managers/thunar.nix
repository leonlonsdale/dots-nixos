{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.programs.file_managers.thunar;
in
{
  options.modules.programs.file_managers.thunar = {
    enable = lib.mkEnableOption "Thunar file manager";

    plugins = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable common Thunar plugins and related services (only applies if Thunar is enabled)";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages =
      with pkgs;
      [ thunar ]
      ++ lib.optionals cfg.plugins [
        thunar-archive-plugin
        thunar-volman
        tumbler
      ];

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = "*";
    };

    services.gvfs.enable = lib.mkIf cfg.plugins (lib.mkDefault true);

    services.tumbler.enable = lib.mkIf cfg.plugins (lib.mkDefault true);
  };
}
