{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.dev.languages.sql;
in
{
  options.modules.dev.languages.sql.enable = lib.mkEnableOption "SQL development tools";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      sqls
      pgformatter
    ];
  };
}
