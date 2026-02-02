{
  config,
  lib,
  inputs,
  username,
  ...
}:
let
  cfg = config.modules.appearance.ui.dms;
in
{
  imports = [ inputs.dms.nixosModules.greeter ];

  options.modules.appearance.ui.dms = {
    enable = lib.mkEnableOption "Dank Material Shell";
    greeter.enable = lib.mkEnableOption "Dank Greeter";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.greeter.enable {
      programs.dank-material-shell.greeter = {
        enable = true;
        compositor.name = "niri";
        configHome = "/home/${username}";
        logs = {
          save = true;
          path = "/tmp/dms-greeter.log";
        };
      };
    })

    (lib.mkIf cfg.enable {
      home-manager.users.${username} = {
        imports = [
          inputs.dms.homeModules.dank-material-shell
          inputs.dms.homeModules.niri
        ];

        programs.dank-material-shell = {
          enable = true;
          systemd.enable = true;
          systemd.restartIfChanged = true;

          niri = {
            enableSpawn = false;
            enableKeybinds = false;
            includes = {
              enable = true;
              override = true;
              originalFileName = "hm";
              filesToInclude = [
                "alttab"
                "binds"
                "colors"
                "layout"
                "outputs"
                "wpblur"
                "cursor"
              ];
            };
          };

          # Feature Toggles
          enableSystemMonitoring = true;
          enableDynamicTheming = true;
          enableAudioWavelength = true;
          enableVPN = true;
          enableCalendarEvents = true;
          enableClipboardPaste = true;

          clipboardSettings = {
            maxHistory = 25;
            maxEntrySize = 5242880;
            autoClearDays = 1;
            clearAtStartup = true;
            disablePersist = true;
          };
        };

        programs.niri.settings = {
          input.keyboard.xkb.layout = "gb";
        };
      };

      systemd.user.services.niri-flake-polkit.enable = lib.mkForce false;
    })
  ];
}
