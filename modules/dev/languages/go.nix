{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.dev.languages.go;
in
{
  options.modules.dev.languages.go.enable = lib.mkEnableOption "Go development tools";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      go
      gopls
      gotools
      golangci-lint
      golangci-lint-langserver
    ];
  };
}
