{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.modules.appearance.ui.icons.qt;
in
{
  options.modules.appearance.ui.icons.qt = {
    enable = lib.mkEnableOption "System-wide QT/GTK Icon Theme (Breeze)";
  };

  config = lib.mkIf cfg.enable {
    # environment.sessionVariables = {
    #   QT_QPA_PLATFORMTHEME = "qt6ct";
    #   QT_QPA_PLATFORM = "wayland;xcb";
    #   QT_STYLE_OVERRIDE = "kvantum";
    # };
    # environment.systemPackages = with pkgs; [
    #   kdePackages.breeze-icons
    #   kdePackages.qtwayland
    #   kdePackages.qt6ct
    #   kdePackages.qtstyleplugin-kvantum
    # ];

    home-manager.users.${username} = {
      qt = {
        enable = true;
        platformTheme.name = "qtct";
        style.name = "kvantum";

        qt6ctSettings = {
          Appearance = {
            icon_theme = "breeze-dark";
            style = "kvantum";
          };
        };
      };

      gtk = {
        enable = true;
        iconTheme = {
          name = lib.mkForce "breeze-dark";
          package = lib.mkForce pkgs.kdePackages.breeze-icons;
        };
      };
    };
  };
}
