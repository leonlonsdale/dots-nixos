{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.modules.cli.tealdeer.enable = lib.mkEnableOption "tealdeer (man alternative)";
  config = lib.mkIf config.modules.cli.tealdeer.enable {
    environment.systemPackages = [ pkgs.tealdeer ];
  };
}
