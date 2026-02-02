{ config, lib, ... }:

let
  cfg = config.modules.appearance.desktops.gnome;
in
{
  options.modules.appearance.desktops.gnome.enable = lib.mkEnableOption "Gnome Desktop";

  config = lib.mkIf cfg.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
  };
}
