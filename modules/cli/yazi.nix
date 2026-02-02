{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.modules.cli.yazi;
in
{
  options.modules.cli.yazi.enable = lib.mkEnableOption "yazi file manager";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.yazi ];

    home-manager.users.${username}.programs.yazi = {
      enable = true;
    };
  };
}
