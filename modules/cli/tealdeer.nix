{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.modules.cli.tealdeer;

  zshEnabled = config.modules.shell.zsh.enable or false;
  fishEnabled = config.modules.shell.fish.enable or false;
  bashEnabled = config.modules.shell.bash.enable or false;

  tealdeerAliases = {
    man = "tldr";
  };
in
{
  options.modules.cli.tealdeer.enable =
    lib.mkEnableOption "tealdeer (fast Rust implementation of tldr)";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.tealdeer ];

    home-manager.users.${username} = {
      programs.zsh.shellAliases = lib.mkIf zshEnabled tealdeerAliases;
      programs.fish.shellAliases = lib.mkIf fishEnabled tealdeerAliases;
      programs.bash.shellAliases = lib.mkIf bashEnabled tealdeerAliases;

      home.file.".config/tealdeer/config.toml".text = ''
        [updates]
        auto_update = true
      '';
    };
  };
}
