{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.modules.cli.bat;
in
{
  options.modules.cli.bat.enable = lib.mkEnableOption "bat (cat clone with wings)";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.bat ];

    home-manager.users.${username} = {
      programs.bat = {
        enable = true;
        config = {
          italic-text = "always";
        };
      };

      # programs.bat.catppuccin.enable = true;
    };
  };
}
