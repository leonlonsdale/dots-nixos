{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.programs.productivity.obsidian;
in
{
  options.modules.programs.productivity.obsidian = {
    enable = mkEnableOption "Obsidian";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      obsidian
    ];
  };
}
