{
  config,
  lib,
  pkgs,
  username,
  ...
}:

let
  cfg = config.modules.dev.cli.gh;
in
{
  options.modules.dev.cli.gh = {
    enable = lib.mkEnableOption "GitHub CLI";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.gh ];

    home-manager.users.${username} = {
      programs.gh = {
        enable = true;
        settings = {
          git_protocol = "ssh";
          prompt = "enabled";
        };
      };
    };
  };
}
