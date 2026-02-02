{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.modules.cli.zellij.enable = lib.mkEnableOption "zellij terminal multiplexer";
  config = lib.mkIf config.modules.cli.zellij.enable {
    environment.systemPackages = [ pkgs.zellij ];
  };
}
