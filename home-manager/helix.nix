{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      # theme = "adwaita-dark";
      theme = "tokyonight_moon";
      keys.normal = {
        esc = [
          "collapse_selection"
          "keep_primary_selection"
        ];
        X = [ "extend_line_above" ];
      };
      editor = {
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        statusline = {
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };
        end-of-line-diagnostics = "hint";
        inline-diagnostics.cursor-line = "warning";
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          # language-servers = [ "nixd" "nil" ];
          formatter = {
            command = "nixfmt";
          };
        }
        {
          name = "latex";
          language-servers = [
            "texlab"
            "harper-ls"
          ];
        }
        {
          name = "markdown";
          language-servers = [
            "marksman"
            "harper-ls"
          ];
          soft-wrap = {
            enable = true;
          };
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "markdown"
              "--prose-wrap"
              "never"
            ];
          };
        }
      ];
      language-server = {
        harper-ls = {
          command = "harper-ls";
          args = [ "--stdio" ];
        };
      };
    };
    package = pkgs.helix;
  };
  home.packages = with pkgs; [
    wl-clipboard
    wl-clipboard-x11
    # LSP and tools that I want always available
    marksman
    texlab
    harper
    nil
    nixd
    nixfmt-rfc-style
    nodePackages.prettier
    yazi
    lazygit
  ];
}
