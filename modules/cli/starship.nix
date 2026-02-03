{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.modules.cli.starship;

  zshEnabled = config.modules.shell.zsh.enable or false;
  fishEnabled = config.modules.shell.fish.enable or false;
  bashEnabled = config.modules.shell.bash.enable or false;
in
{
  options.modules.cli.starship = {
    enable = lib.mkEnableOption "Starship prompt";
    palette = lib.mkOption {
      type = lib.types.enum [
        "kanso"
        "tokyonight"
        "gruvbox"
        "kanagawa"
        "catppuccin_mocha"
        "darkplus"
        "ayumirage"
        "everforestdark"
        "github_dark"
      ];
      default = "catppuccin_mocha";
      description = "The colour palette to use for Starship";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.starship ];

    home-manager.users.${username} = {
      programs.starship = {
        enable = true;
        enableZshIntegration = zshEnabled;
        enableFishIntegration = fishEnabled;
        enableBashIntegration = bashEnabled;

        settings = lib.mkForce {
          palette = cfg.palette;
          add_newline = true;

          format = lib.concatStrings [
            "([](white)\${custom.git_config_email}$git_branch[](white))"
            "$line_break"
            "$directory"
            "$python"
            "$nodejs"
            "$rust"
            "$golang"
            "$lua"
            "$php"
            "$java"
            "$kotlin"
            "$haskell"
            "$elixir"
            "$elm"
            "$ruby"
            "$perl"
            "$c"
            "$cpp"
            "$cmake"
            "$zig"
            "$nim"
            "$dart"
            "$swift"
            "$docker_context"
            "$terraform"
            "$nix_shell"
            "$package"
            "$git_status"
            "$line_break"
            "$character"
          ];

          custom.git_config_email = {
            command = "git config user.email";
            format = "[ $output](bg:white fg:0 bold)";
            when = "git rev-parse --is-inside-work-tree >/dev/null 2>&1";
          };

          git_branch = {
            symbol = "󰊢 ";
            style = "bg:white fg:0 bold";
            format = "[[ on ](bg:white fg:8)$symbol$branch]($style)";
          };

          git_status = {
            style = "status";
          };

          directory = {
            truncation_length = 1;
            read_only = " 🔒";
            style = "blue";
            format = "[in ](green)[󰝰 $path]($style)[$read_only]($read_only_style) ";
          };

          python = {
            symbol = " ";
            format = "[$symbol($version)]($style) ";
            style = "bold #3776AB";
          };
          nodejs = {
            symbol = " ";
            format = "[$symbol($version)]($style) ";
            style = "bold #339933";
          };
          rust = {
            symbol = " ";
            format = "[$symbol($version)]($style) ";
            style = "bold #CE412B";
          };
          golang = {
            symbol = " ";
            format = "[$symbol($version)]($style) ";
            style = "bold #00ADD8";
          };
          lua = {
            symbol = " ";
            format = "[$symbol($version)]($style) ";
            style = "bold #000080";
          };
          php = {
            symbol = " ";
            format = "[$symbol($version)]($style) ";
            style = "bold #777BB4";
          };
          java = {
            symbol = " ";
            format = "[$symbol($version)]($style) ";
            style = "bold #ED8B00";
          };
          kotlin = {
            symbol = "󱈙 ";
            format = "[$symbol($version)]($style) ";
            style = "bold #7F52FF";
          };
          haskell = {
            symbol = " ";
            format = "[$symbol($version)]($style) ";
            style = "bold #5D4F85";
          };
          elixir = {
            symbol = " ";
            format = "[$symbol($version)]($style) ";
            style = "bold #4E2A8E";
          };
          elm = {
            symbol = " ";
            format = "[$symbol($version)]($style) ";
            style = "bold #60B5CC";
          };
          ruby = {
            symbol = " ";
            format = "[$symbol($version)]($style) ";
            style = "bold #CC342D";
          };
          perl = {
            symbol = " ";
            format = "[$symbol($version)]($style) ";
            style = "bold #39457E";
          };
          c = {
            symbol = " ";
            format = "[$symbol($version)]($style) ";
            style = "bold #A8B9CC";
          };
          cpp = {
            symbol = " ";
            format = "[$symbol($version)]($style) ";
            style = "bold #00599C";
          };
          cmake = {
            symbol = "󰔊 ";
            format = "[$symbol($version)]($style) ";
            style = "bold #064F8C";
          };
          zig = {
            symbol = " ";
            format = "[$symbol($version)]($style) ";
            style = "bold #F7A41D";
          };
          nim = {
            symbol = " ";
            format = "[$symbol($version)]($style) ";
            style = "bold #FFE953";
          };
          dart = {
            symbol = " ";
            format = "[$symbol($version)]($style) ";
            style = "bold #0175C2";
          };
          swift = {
            symbol = " ";
            format = "[$symbol($version)]($style) ";
            style = "bold #F05138";
          };
          docker_context = {
            symbol = "󰡨 ";
            format = "[$symbol($context)]($style) ";
            style = "bold #2496ED";
          };
          terraform = {
            symbol = "󱁢 ";
            format = "[$symbol($version)]($style) ";
            style = "bold #844FBA";
          };
          nix_shell = {
            symbol = " ";
            format = "[$symbol($state)]($style) ";
            style = "bold #7EBAE4";
          };
          package = {
            symbol = "󰏗 ";
            format = "[$symbol($version)]($style) ";
            style = "bold #F2BF26";
          };

          character = {
            success_symbol = "[➜](bold green)";
            error_symbol = "[➜](bold red)";
          };

          palettes = {
            kanso = {
              red = "#c4746e";
              green = "#8a9a7b";
              blue = "#7FB4CA";
              orange = "#E69875";
            };
            tokyonight = {
              red = "#f7768e";
              green = "#9ece6a";
              blue = "#7aa2f7";
              orange = "#ff9e64";
            };
            gruvbox = {
              red = "#fb4934";
              green = "#b8bb26";
              blue = "#83a598";
              orange = "#fe8019";
            };
            kanagawa = {
              red = "#E46876";
              green = "#98BB6C";
              blue = "#7FB4CA";
              orange = "#FFA066";
            };
            catppuccin_mocha = {
              red = "#F38BA8";
              green = "#A6E3A1";
              blue = "#89B4FA";
              orange = "#FAB387";
            };
            darkplus = {
              red = "#ff1212";
              green = "#4EC9B0";
              blue = "#569CD6";
              orange = "#CE9178";
            };
            ayumirage = {
              red = "#f28779";
              green = "#D5FF80";
              blue = "#73D0FF";
              orange = "#FFAD66";
            };
            everforestdark = {
              red = "#E67E81";
              green = "#7EB98C";
              blue = "#7FBBB3";
              orange = "#E69875";
            };
            github_dark = {
              red = "#F25D5D";
              green = "#62D863";
              blue = "#8AB6D6";
              orange = "#F69D50";
            };
          };
        };
      };
    };
  };
}
