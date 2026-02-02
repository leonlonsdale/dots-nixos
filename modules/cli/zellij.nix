{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.modules.cli.zellij;
in
{
  options.modules.cli.zellij.enable = lib.mkEnableOption "zellij terminal multiplexer";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.zellij ];

    home-manager.users.${username}.programs.zellij = {
      enable = true;
    };
  };
}
