{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.modules.appearance.desktops.niri;
in
{
  options.modules.appearance.desktops.niri = {
    enable = lib.mkEnableOption "Niri compositor";
  };

  imports = [ inputs.niri.nixosModules.niri ];

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;

    programs.niri.enable = true;
    programs.niri.package = pkgs.niri-unstable;
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  };
}
