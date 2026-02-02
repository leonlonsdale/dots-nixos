{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.dev.languages.web;
in
{
  options.modules.dev.languages.web.enable = lib.mkEnableOption "Web development tools";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # -- Runtimes
      bun
      nodejs_24

      # -- LSP
      nodePackages.typescript-language-server
      tailwindcss-language-server
      nodePackages.vscode-langservers-extracted

      # -- Formatters & Linters
      biome
      nodePackages.prettier
    ];
  };
}
