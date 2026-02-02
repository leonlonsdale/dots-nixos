{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.dev.languages.toml;
in
{
  options.modules.dev.languages.toml.enable = lib.mkEnableOption "TOML development tools";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      taplo
    ];
  };
}
