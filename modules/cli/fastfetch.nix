{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.modules.cli.fastfetch;
in
{
  options.modules.cli.fastfetch.enable = lib.mkEnableOption "fastfetch icon-only rice";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.fastfetch ];

    home-manager.users.${username} = {
      programs.fastfetch = {
        enable = true;
        settings = {
          logo = {
            source = "nixos";
            padding = {
              top = 1;
              right = 3;
            };
          };
          display = {
            separator = " ";
            color = {
              keys = "magenta";
            };
          };
          modules = [
            # --- Software ---
            {
              type = "custom";
              format = "┌────────── Software ──────────┐";
              outputColor = "magenta";
            }
            {
              type = "os";
              key = "│ 󱄅 ";
              format = "{2} {8}";
            }
            {
              type = "kernel";
              key = "│ 󰌽 ";
              format = "{2}";
            }
            {
              type = "packages";
              key = "│ 󰏖 ";
              # No complex tokens—let Fastfetch do its job.
              # It will display "123 (nix-system), 45 (nix-user)" automatically.
            }
            {
              type = "shell";
              key = "│ 󰈺 ";
              format = "{1}";
            }
            {
              type = "wm";
              key = "│ 󱂬 ";
              format = "{2}";
            }
            {
              type = "custom";
              format = "└──────────────────────────────┘";
              outputColor = "magenta";
            }

            "break"

            # --- Hardware ---
            {
              type = "custom";
              format = "┌────────── Hardware ──────────┐";
              outputColor = "magenta";
            }
            {
              type = "host";
              key = "│ 󰌢 ";
            }
            {
              type = "cpu";
              key = "│ 󰻠 ";
              format = "{1}";
            }
            {
              type = "gpu";
              key = "│ 󰢮 ";
              format = "{2}";
            }
            {
              type = "memory";
              key = "│ 󰍛 ";
              format = "{1} / {2}";
            }
            {
              type = "disk";
              key = "│ 󰋊 ";
              format = "{1} / {2}";
            }
            {
              type = "custom";
              format = "└──────────────────────────────┘";
              outputColor = "magenta";
            }

            "break"

            # --- Displays ---
            {
              type = "custom";
              format = "┌────────── Displays ──────────┐";
              outputColor = "magenta";
            }
            {
              type = "display";
              key = "│ 󰍹 ";
              # {name} = Model Name
              # {7}" = Diagonal size in inches (e.g., 27")
              # {1}x{2} @ {3}Hz = Resolution and Refresh Rate
              format = "{name} \({12}\"\) {1}x{2} @ {3}Hz";
            }
            {
              type = "custom";
              format = "└──────────────────────────────┘";
              outputColor = "magenta";
            }

            "break"

            # --- Stats ---
            {
              type = "custom";
              format = "┌──────────── Stats ───────────┐";
              outputColor = "magenta";
            }
            {
              type = "datetime";
              key = "│ 󰃭 ";
              format = "{1}-{3}-{11}";
            }
            {
              type = "uptime";
              key = "│ 󱘖 ";
              format = "{1}d {2}h {3}m";
            }
            {
              type = "custom";
              format = "└──────────────────────────────┘";
              outputColor = "magenta";
            }

            "break"
            {
              type = "colors";
              symbol = "square";
            }
          ];
        };
      };
    };
  };
}
