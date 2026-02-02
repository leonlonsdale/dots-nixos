{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.modules.cli.jq.enable = lib.mkEnableOption "fzf (fuzzy finder)";
  config = lib.mkIf config.modules.cli.jq.enable {
    environment.systemPackages = [ pkgs.jq ];
  };
}
