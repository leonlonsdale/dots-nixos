{
  config,
  lib,
  username,
  ...
}:
let
  cfg = config.modules.shell.zsh;
in
{
  options.modules.shell.zsh = {
    enable = lib.mkEnableOption "Enable zsh at system level with home config";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh.enable = true;

    home-manager.users.${username} = {
      programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        enableCompletion = true;
        initContent = ''
          zsh-newuser-install() { :; }
          fastfetch
        '';

        shellAliases = {
          cl = "clear";
        };
      };
    };
  };
}
