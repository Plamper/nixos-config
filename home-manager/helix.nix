{ pkgs, inputs, ... }:
{
  imports = [
    inputs.helix-plugins.homeManagerModules.default
  ];

  nixpkgs.overlays = [
    inputs.helix-plugins.overlays.default
    (final: prev: {
      helixPlugins = prev.helixPlugins.overrideScope (hpFinal: hpPrev: {
        trail = hpPrev.trail.overrideAttrs (old: {
          postPatch = (old.postPatch or "") + ''
            substituteInPlace trail.scm \
              --replace-fail '(string-append *trail-steel-home* "/cogs/trail")' '(string-append *trail-home* "/.local/share/trail")'
          '';
        });
      });
    })
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = pkgs.unstable.steelix;
    plugins = with pkgs.helixPlugins; [
      forest
      trail
      splash-hx
    ];
    settings = {
      # theme = "adwaita-dark";
      theme = "kanagawa-dragon";
      keys.normal = {
        esc = [
          "collapse_selection"
          "keep_primary_selection"
        ];
        X = [ "extend_line_above" ];
        C-g = [
          ":write-all"
          ":new"
          ":insert-output lazygit"
          ":set mouse false" # First disable mouse to hint helix into activating it
          ":set mouse true"
          ":buffer-close!"
          ":redraw"
          ":reload-all"
        ];
        space = {
          z = ":forest-open";
          t = ":trail-open";
        };
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
    nixfmt
    yazi
    lazygit
  ];

  xdg.configFile."helix/helix.scm".text = ''
    (require (prefix-in helix. "helix/commands.scm"))

    ;; Load Steelix plugins
    (require "forest/forest.scm")
    (require "trail/trail.scm")
    (require "splash-hx/splash.scm")

    ;; Expose commands globally to Helix (:forest-open, :trail-open, :show-splash)
    (provide forest-open
             forest-close
             forest-configure!
             forest-set-style!
             trail-open
             show-splash)

    ;; Render splash screen when launched without file arguments
    (when (equal? (command-line) '())
      (show-splash))
  '';

  xdg.configFile."helix/init.scm".text = ''
    ;; User initialization
  '';
}
