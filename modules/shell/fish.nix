{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.modules.shell.fish;
  fzfEnabled = config.modules.cli.fzf.enable or false;
  batEnabled = config.modules.cli.bat.enable or false;
in
{
  options.modules.shell.fish = {
    enable = lib.mkEnableOption "fish shell";
  };

  config = lib.mkIf cfg.enable {
    programs.fish.enable = true;

    home-manager.users.${username} = {
      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting
          fastfetch
        '';
        shellAliases = {
          cl = "clear";
        };
      };

      home.packages =
        with pkgs.fishPlugins;
        [
          done
        ]
        ++ (lib.optional fzfEnabled fzf-fish)
        ++ (lib.optional (!batEnabled) colored-man-pages);
    };
  };
}
