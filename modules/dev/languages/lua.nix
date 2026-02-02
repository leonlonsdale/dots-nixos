{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.dev.languages.lua;
in
{
  options.modules.dev.languages.lua.enable = lib.mkEnableOption "TOML development tools";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      stylua
      lua-language-server
    ];
  };
}
