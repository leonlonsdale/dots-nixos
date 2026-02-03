{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.modules.cli.fzf;

  zshEnabled = config.modules.shell.zsh.enable or false;
  fishEnabled = config.modules.shell.fish.enable or false;
  bashEnabled = config.modules.shell.bash.enable or false;
in
{
  options.modules.cli.fzf.enable = lib.mkEnableOption "fzf (fuzzy finder)";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.fzf ];

    home-manager.users.${username} = {
      programs.fzf = {
        enable = true;

        enableZshIntegration = zshEnabled;
        enableFishIntegration = fishEnabled;
        enableBashIntegration = bashEnabled;
      };
    };
  };
}
