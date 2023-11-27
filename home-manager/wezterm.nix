{ pkgs, ...}:
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
config.color_scheme = 'GJM (terminal.sexy)'
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
  active_titlebar_bg = '#333333',

  -- The overall background color of the tab bar when
  -- the window is not focused
  inactive_titlebar_bg = '#333333',
}

config.colors = {
  tab_bar = {
    -- The color of the inactive tab bar edge/divider
    inactive_tab_edge = '#575757',
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
    };
   
    home.packages = let
      xdgTermShim = pkgs.writeShellApplication {
  name = "xdg-terminal-exec";

  runtimeInputs = [ pkgs.wezterm ];

  text = ''
    wezterm -e "$@"
  '';
}
;
    in [
      xdgTermShim
    ];
    
  };
}
