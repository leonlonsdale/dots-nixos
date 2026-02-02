{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.modules.programs.browsers.firefox;
in
{
  options.modules.programs.browsers.firefox.enable = lib.mkEnableOption "Firefox Browser";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.firefox ];

    home-manager.users.${username} = {
      programs.firefox = {
        enable = true;
      };

    };
  };
}
