{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.modules.dev.editors.neovim.enable = lib.mkEnableOption "eza (modern ls replacement)";
  config = lib.mkIf config.modules.dev.editors.neovim.enable {
    environment.systemPackages = [ pkgs.neovim ];
  };
}
