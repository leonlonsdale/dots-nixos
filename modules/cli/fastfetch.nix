{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.modules.cli.fastfetch.enable = lib.mkEnableOption "fast fetch";
  config = lib.mkIf config.modules.cli.fastfetch.enable {
    environment.systemPackages = [ pkgs.fastfetch ];
  };
}
