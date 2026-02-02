{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.modules.cli.fzf;
in
{
  options.modules.cli.fzf.enable = lib.mkEnableOption "fzf (fuzzy finder)";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.fzf ];

    home-manager.users.${username}.programs.fzf = {
      enable = true;
    };
  };
}
