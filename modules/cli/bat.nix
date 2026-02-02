{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.modules.cli.bat.enable = lib.mkEnableOption "bat (cat clone with wings)";
  config = lib.mkIf config.modules.cli.bat.enable {
    environment.systemPackages = [ pkgs.bat ];
  };
}
