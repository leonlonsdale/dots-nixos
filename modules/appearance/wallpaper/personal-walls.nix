{
  config,
  lib,
  inputs,
  username,
  ...
}:
let
  cfg = config.modules.appearance.wallpapers.personal-walls;
in
{
  options.modules.appearance.wallpapers.personal-walls = {
    enable = lib.mkEnableOption "Personal wallpapers via hjem";
  };

  config = lib.mkIf cfg.enable {
    hjem.users.${username} = {
      enable = true;
      files."wallpaper".source = inputs.wallpaper;
    };
  };
}
