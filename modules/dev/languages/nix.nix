{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.dev.languages.nix;
in
{
  options.modules.dev.languages.nix.enable = lib.mkEnableOption "Nix development tools";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nixd # Or 'nil' if you prefer
      nixpkgs-fmt
    ];
  };
}
