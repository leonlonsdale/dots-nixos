{
  config,
  lib,
  pkgs,
  username,
  ...
}:

let
  cfg = config.modules.programs.browsers.librewolf;
in
{
  options.modules.programs.browsers.librewolf = {
    enable = lib.mkEnableOption "LibreWolf Browser";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.librewolf ];

    home-manager.users.${username} = {
      programs.librewolf = {
        enable = true;
        settings = {
          "webgl.disabled" = false;
          "privacy.resistFingerprinting" = true;
          "privacy.clearOnShutdown.history" = false;
          "identity.fxaccounts.enabled" = false;
        };
      };
    };
  };
}
