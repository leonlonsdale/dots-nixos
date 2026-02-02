{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.dev.languages.markdown;
in
{
  options.modules.dev.languages.markdown.enable = lib.mkEnableOption "Markdown tools";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      marksman
      markdown-oxide
      nodePackages.prettier
    ];
  };
}
