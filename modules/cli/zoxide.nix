{
  config,
  lib,
  username,
  ...
}:
let
  cfg = config.modules.cli.zoxide;
in
{
  options.modules.cli.zoxide = {
    enable = lib.mkEnableOption "Enable zoxide (smarter cd command) with shell integrations";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        options = [ "--cmd cd" ];
      };
    };
  };
}
