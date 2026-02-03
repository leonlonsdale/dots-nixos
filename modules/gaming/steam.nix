{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.gaming.steam;
in
{
  options.modules.gaming.steam = {
    enable = lib.mkEnableOption "Steam gaming profile";
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      mangohud
      protonup-qt
      lutris
    ];
  };
}
