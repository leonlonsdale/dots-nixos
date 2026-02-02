{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.modules.cli.fzf.enable = lib.mkEnableOption "fzf (fuzzy finder)";
  config = lib.mkIf config.modules.cli.fzf.enable {
    environment.systemPackages = [ pkgs.fzf ];
  };
}
