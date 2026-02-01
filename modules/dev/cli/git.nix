{ config, lib, pkgs, username, gitName, gitEmail, ... }:
let
  cfg = config.modules.dev.cli.git;
in
{
  options.modules.dev.cli.git.enable = lib.mkEnableOption "Git version control";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.git ];

    home-manager.users.${username} = {
      programs.git = {
        enable = true;
        settings.user.name = gitName;
        settings.user.email= gitEmail;
        settings.init.defaultBranch = "main";
      };

      programs.delta = {
        enable = true;
        options.side-by-side = true;
        options.line-numbers = true;
        options.navigate = true;
      };
    };
  };
}
