{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.modules.cli.yazi.enable = lib.mkEnableOption "yazi file manager";
  config = lib.mkIf config.modules.cli.yazi.enable {
    environment.systemPackages = [ pkgs.yazi ];
  };
}
