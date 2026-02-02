{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.dev.languages.python;
in
{
  options.modules.dev.languages.python.enable = lib.mkEnableOption "Python development tools";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (python3.withPackages (
        ps: with ps; [
          pip
          requests
        ]
      ))
      basedpyright
      ruff
    ];
  };
}
