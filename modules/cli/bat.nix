{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.modules.cli.bat;

  zshEnabled = config.modules.shell.zsh.enable or false;
  fishEnabled = config.modules.shell.fish.enable or false;
  bashEnabled = config.modules.shell.bash.enable or false;

  batAliases = {
    cat = "bat --style=plain";
  };
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

      programs.zsh.shellAliases = lib.mkIf zshEnabled batAliases;
      programs.fish.shellAliases = lib.mkIf fishEnabled batAliases;
      programs.bash.shellAliases = lib.mkIf bashEnabled batAliases;
    };
  };
}
