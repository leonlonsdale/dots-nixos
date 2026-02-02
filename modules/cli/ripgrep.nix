{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.modules.cli.ripgrep.enable = lib.mkEnableOption "fzf (fuzzy finder)";
  config = lib.mkIf config.modules.cli.ripgrep.enable {
    environment.systemPackages = [ pkgs.ripgrep ];
  };
}
