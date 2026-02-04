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
      comic-sans = {
        prettyName = lib.mkDefault "Comic Sans MS";
        package = lib.mkDefault pkgs.corefonts;
      };
      comic-shanns = {
        prettyName = lib.mkDefault "ComicShannsMono Nerd Font";
        package = lib.mkDefault pkgs.nerd-fonts.comic-shanns-mono;
      };
    };

    fonts.packages =
      (lib.mapAttrsToList (name: value: value.package) (lib.filterAttrs (name: value: value.enable) cfg))
      ++ [ pkgs.nerd-fonts.symbols-only ];
  };
}
