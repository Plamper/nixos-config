{ pkgs, ... }:
{
  config = {
    programs.wezterm = {
      enable = true;
      extraConfig = ''
        -- Pull in the wezterm API
        local wezterm = require 'wezterm'

        -- This table will hold the configuration.
        local config = {}

        -- In newer versions of wezterm, use the config_builder which will
        -- help provide clearer error messages
        if wezterm.config_builder then
          config = wezterm.config_builder()
        end

        -- This is where you actually apply your config choices

        -- For example, changing the color scheme:
        config.color_scheme = 'Tokyo Night Storm'
        config.enable_wayland = false
        config.window_frame = {
          -- The font used in the tab bar.
          -- Roboto Bold is the default; this font is bundled
          -- with wezterm.
          -- Whatever font is selected here, it will have the
          -- main font setting appended to it to pick up any
          -- fallback fonts you may have used there.
          font = wezterm.font { family = 'Cantarell', weight = 'Regular' },

          -- The size of the font in the tab bar.
          -- Default to 10.0 on Windows but 12.0 on other systems
          font_size = 12.0,

          -- The overall background color of the tab bar when
          -- the window is focused
          active_titlebar_bg = '#303030',

          -- The overall background color of the tab bar when
          -- the window is not focused
          inactive_titlebar_bg = '#242424',
        }

        config.mouse_bindings = {
          -- Change the default selection behavior so that it only selects text,
          -- but doesn't copy it to a clipboard or open hyperlinks.
          {
            event={Up={streak=1, button="Left"}},
            mods="NONE",
            action=wezterm.action{ExtendSelectionToMouseCursor="Cell"}
          },
          -- Don't automatically copy the selection to the clipboard
          -- when double clicking a word
          {
            event={Up={streak=2, button="Left"}},
            mods="NONE",
            action="Nop",
          },
          -- Ctrl-click will open the link under the mouse cursor
          {
            event={Up={streak=1, button="Left"}},
            mods="CTRL",
            action="OpenLinkAtMouseCursor",
          },
        }

        config.colors = {
          tab_bar = {
            -- The color of the inactive tab bar edge/divider
            inactive_tab_edge = '#575757',
          -- The active tab is the one that has focus in the window
            active_tab = {
              -- The color of the background area for the tab
              bg_color = '#444444',
              -- The color of the text for the tab
              fg_color = '#FFFFFF',
            },
            inactive_tab = {
              -- The color of the background area for the tab
              bg_color = '#303030',
              -- The color of the text for the tab
              fg_color = '#FFFFFF',
            },
            new_tab = {
              bg_color = '#303030',
              fg_color = '#FFFFFF',

              -- The same options that were listed under the `active_tab` section above
              -- can also be used for `new_tab`.
            },
          },
        }
        config.font = wezterm.font {
          family = 'Fira Code',
          weight = 'Medium',
          harfbuzz_features = { 'cv02', 'ss01', 'ss03', 'ss05', 'ss07' },
        }
        config.font_size = 13.0;

        -- and finally, return the configuration to wezterm
        return config
      '';

      colorSchemes = {
        adwaita-dark = {
          ansi = [
            "#3d3846"
            "#e01b24"
            "#2ec27e"
            "#ff7800"
            "#1e78e4"
            "#9841bb"
            "#0ab9dc"
            "#c0bfbc"
          ];
          brights = [
            "#5e5c64"
            "#f66151"
            "#8ff0a4"
            "#ffbe6f"
            "#51a1ff"
            "#c061cb"
            "#4fd2fd"
            "#f6f5f4"
          ];
          background = "#1E1E1E";
          cursor_fg = "#1D1D1D";
          cursor_border = "#BEAF8A";
          cursor_bg = "#C0BFBC";
          foreground = "#ffffff";
          selection_bg = "#193D66";
          selection_fg = "#C0BFBC";
        };
      };
    };

    home.packages =
      let
        xdgTermShim = pkgs.writeShellApplication {
          name = "xdg-terminal-exec";

          runtimeInputs = [ pkgs.wezterm ];

          text = ''
            wezterm -e "$@"
          '';
        }
        ;
      in
      [
        xdgTermShim
      ];

  };
}
