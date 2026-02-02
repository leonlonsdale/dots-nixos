{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.modules.cli.fd.enable = lib.mkEnableOption "eza (modern ls replacement)";
  config = lib.mkIf config.modules.cli.fd.enable {
    environment.systemPackages = [ pkgs.fd ];
  };
}
