{
  config,
  lib,
  pkgs,
  username,
  ...
}:

let
  cfg = config.modules.dev.editors.helix;
in
{
  options.modules.dev.editors.helix.enable = lib.mkEnableOption "Custom Helix configuration";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.helix ];

    home-manager.users.${username} = {
      programs.helix = {
        enable = true;
        # Uses the master/flake version provided by the overlay
        package = pkgs.helix;
        defaultEditor = true;

        settings = {
          theme = "tokyonight_storm";
          editor = {
            true-color = true;
            undercurl = true;
            color-modes = true;
            line-number = "relative";
            cursorline = true;
            popup-border = "all";
            completion-replace = true;
            rulers = [ 80 ];
            indent-heuristic = "tree-sitter";
            end-of-line-diagnostics = "hint";
            rainbow-brackets = true;
            statusline = {
              left = [
                "mode"
                "file-base-name"
                "file-modification-indicator"
                "spinner"
              ];
              center = [ "workspace-diagnostics" ];
              right = [ "version-control" ];
              separator = "●";
              mode = {
                normal = "N";
                insert = "I";
                select = "S";
              };
            };
            cursor-shape = {
              insert = "bar";
              normal = "block";
              select = "underline";
            };
            file-picker.hidden = false;
            indent-guides = {
              render = true;
              skip-levels = 1;
              character = "▏";
            };
            soft-wrap.enable = true;
            inline-diagnostics = {
              cursor-line = "hint";
              max-wrap = 10;
              max-diagnostics = 5;
              prefix-len = 1;
            };
          };
          keys.normal = {
            esc = [
              "collapse_selection"
              "keep_primary_selection"
            ];
            "S-up" = [
              "extend_to_line_bounds"
              "delete_selection"
              "move_line_up"
              "paste_before"
            ];
            "S-down" = [
              "extend_to_line_bounds"
              "delete_selection"
              "paste_after"
            ];
            G = "goto_file_end";
            "{" = [ "goto_next_paragraph" ];
            "}" = [ "goto_prev_paragraph" ];
            space = {
              q = ":quit";
              w = ":write";
              "*" = [
                "move_char_right"
                "move_prev_word_start"
                "move_next_word_end"
                "search_selection"
                "search_next"
              ];
              r = ":config-reload";
              l = ":lsp-restart";
              "Q" = ":write-quit-all";
              t.i = ":toggle lsp.display-inlay-hints";
            };
          };
          keys.select = {
            "{" = [ "goto_next_paragraph" ];
            "}" = [ "goto_prev_paragraph" ];
          };
        };

        languages = {
          language-server = {
            golangci-lint-lsp.command = "golangci-lint-langserver";
            basedpyright.command = "basedpyright-langserver";
            ruff = {
              command = "ruff";
              args = [ "server" ];
            };
            biome = {
              command = "biome";
              args = [ "lsp-proxy" ];
            };
            tailwindcss-ls = {
              command = "tailwindcss-language-server";
              args = [ "--stdio" ];
            };
            vscode-eslint-language-server = {
              command = "vscode-eslint-language-server";
              args = [ "--stdio" ];
            };
            vscode-json-language-server = {
              command = "vscode-json-language-server";
              args = [ "--stdio" ];
            };
            vscode-html-language-server = {
              command = "vscode-html-language-server";
              args = [ "--stdio" ];
            };
            vscode-css-language-server = {
              command = "vscode-css-language-server";
              args = [ "--stdio" ];
            };
            sql-language-server = {
              command = "sql-language-server";
              args = [
                "up"
                "--method"
                "stdio"
              ];
            };
          };
          language = [
            {
              name = "nix";
              auto-format = true;
              formatter = {
                command = "${pkgs.nixfmt}/bin/nixfmt";
              };
            }
            {
              name = "go";
              auto-format = true;
              formatter = {
                command = "goimports";
              };
              language-servers = [
                "gopls"
                "golangci-lint-lsp"
              ];
            }
            {
              name = "python";
              language-servers = [
                "ruff"
                "basedpyright"
              ];
              auto-format = true;
            }
            {
              name = "html";
              language-servers = [
                "vscode-html-language-server"
                "tailwindcss-ls"
              ];
              formatter = {
                command = "prettier";
                args = [
                  "--parser"
                  "html"
                ];
              };
              auto-format = true;
            }
            {
              name = "css";
              language-servers = [
                "vscode-css-language-server"
                "tailwindcss-ls"
              ];
              formatter = {
                command = "prettier";
                args = [
                  "--parser"
                  "css"
                ];
              };
              auto-format = true;
            }
            {
              name = "javascript";
              language-servers = [
                "typescript-language-server"
                "biome"
              ];
              auto-format = true;
            }
            {
              name = "typescript";
              language-servers = [
                "typescript-language-server"
                "biome"
              ];
              auto-format = true;
            }
            {
              name = "tsx";
              language-servers = [
                "typescript-language-server"
                "biome"
                "tailwindcss-ls"
              ];
              auto-format = true;
            }
            {
              name = "sql";
              formatter = {
                command = "pg_format";
                args = [ "-" ];
              };
              auto-format = true;
            }
          ];
        };
      };
    };
  };
}
