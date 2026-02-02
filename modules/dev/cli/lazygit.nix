{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.modules.cli.lazygit.enable = lib.mkEnableOption "Lazygit";
  config = lib.mkIf config.modules.cli.lazygit.enable {
    environment.systemPackages = [ pkgs.lazygit ];
  };
}
