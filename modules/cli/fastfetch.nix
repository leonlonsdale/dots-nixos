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
          logo.source = "none";
          display = {
            separator = "   ";
          };
          modules = [
            {
              type = "custom";
              format = "{#35}╭──────────────────╮";
            }

            {
              type = "os";
              key = "{#35}│ {#0}{#32}󱄅  OS            {#35}│";
              format = "{2} {8}";
            }
            {
              type = "kernel";
              key = "{#35}│ {#0}{#33}󰌽  Kernel        {#35}│";
              format = "{2}";
            }
            {
              type = "packages";
              key = "{#35}│ {#0}{#34}󰏖  Packages      {#35}│";
            }
            {
              type = "shell";
              key = "{#35}│ {#0}{#36}󰈺  Shell         {#35}│";
              format = "{1}";
            }
            {
              type = "wm";
              key = "{#35}│ {#0}{#35}󱂬  WM            {#35}│";
              format = "{2}";
            }

            {
              type = "host";
              key = "{#35}│ {#0}{#32}󰌢  Host          {#35}│";
            }
            {
              type = "cpu";
              key = "{#35}│ {#0}{#33}󰻠  CPU           {#35}│";
              format = "{1}";
            }
            {
              type = "gpu";
              key = "{#35}│ {#0}{#34}󰢮  GPU           {#35}│";
              format = "{2}";
            }
            {
              type = "memory";
              key = "{#35}│ {#0}{#36}󰍛  Memory        {#35}│";
              format = "{1} / {2}";
            }
            {
              type = "disk";
              key = "{#35}│ {#0}{#35}󰋊  Disk          {#35}│";
              format = "{1} / {2}";
            }

            {
              type = "display";
              key = "{#35}│ {#0}{#32}󰍹  Display       {#35}│";
              format = "{name} \({12}\"\) {1}x{2} @ {3} Hz";
            }
            {
              type = "datetime";
              key = "{#35}│ {#0}{#33}󰃭  Date          {#35}│";
              format = "{1}-{3}-{11}";
            }
            {
              type = "uptime";
              key = "{#35}│ {#0}{#34}󱘖  Uptime        {#35}│";
              format = "{1}d {2}h {3}m";
            }

            {
              type = "custom";
              format = "{#35}╰──────────────────╯";
            }

            "break"
            {
              type = "colors";
              symbol = "circle";
            }
          ];
        };
      };
    };
  };
}
