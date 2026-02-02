{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.appearance.desktops.plasma;
in
{
  options.modules.appearance.desktops.plasma.enable = lib.mkEnableOption "KDE Plasma 6 Desktop";

  config = lib.mkIf cfg.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    # Optional: Add KDE specific system packages here
    environment.systemPackages = with pkgs.kdePackages; [
      spectacle # Screenshots
      ark # Compression tool
    ];
  };
}
