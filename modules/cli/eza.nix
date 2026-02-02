{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.modules.cli.eza.enable = lib.mkEnableOption "eza (modern ls replacement)";
  config = lib.mkIf config.modules.cli.eza.enable {
    environment.systemPackages = [ pkgs.eza ];
  };
}
