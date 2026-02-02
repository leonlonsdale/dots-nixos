{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.dev.languages.yaml;
in
{
  options.modules.dev.languages.yaml.enable = lib.mkEnableOption "YAML development tools";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nodePackages.yaml-language-server
    ];
  };
}
