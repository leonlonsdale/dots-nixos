# {
#   config,
#   lib,
#   pkgs,
#   ...
# }:

# let
#   cfg = config.modules.fonts;
# in
# {
#   options.modules.fonts = {
#     hurmit.enable = lib.mkEnableOption "Hurmit Nerd Font";
#     jetbrains.enable = lib.mkEnableOption "JetBrains Mono Nerd Font";
#     victor.enable = lib.mkEnableOption "Victor Mono Nerd Font";
#   };

#   config = {
#     fonts.packages =
#       [ ]
#       ++ lib.optional cfg.hurmit.enable pkgs.nerd-fonts.hurmit
#       ++ lib.optional cfg.jetbrains.enable pkgs.nerd-fonts.jetbrains-mono
#       ++ lib.optional cfg.victor.enable pkgs.nerd-fonts.victor-mono;
#   };
# }

{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.appearance.fonts;
in
{
  options.modules.appearance.fonts = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "font";
          prettyName = lib.mkOption { type = lib.types.str; };
          package = lib.mkOption { type = lib.types.package; };
        };
      }
    );
  };

  config = {
    # We define the data here so it doesn't get wiped out by the host config
    modules.appearance.fonts = {
      jetbrains = {
        prettyName = lib.mkDefault "JetBrainsMono Nerd Font";
        package = lib.mkDefault pkgs.nerd-fonts.jetbrains-mono;
      };
      victor = {
        prettyName = lib.mkDefault "VictorMono Nerd Font";
        package = lib.mkDefault pkgs.nerd-fonts.victor-mono;
      };
      hurmit = {
        prettyName = lib.mkDefault "Hurmit Nerd Font";
        package = lib.mkDefault pkgs.nerd-fonts.hurmit;
      };
    };

    fonts.packages = lib.mapAttrsToList (name: value: value.package) (
      lib.filterAttrs (name: value: value.enable) cfg
    );
  };
}
