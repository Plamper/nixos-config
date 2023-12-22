{ pkgs, config, ... }:
{
  config = {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      terminal = "wezterm";
      font = "Ubuntu Nerd Font 13";
      extraConfig = {
        modi = [ "drun" "window" "run" ];
        # icon-theme = "Papirus-Dark";
        show-icons = true;
        drun-display-format = "{icon} {name}";
        location = 0;
        disable-history = false;
        sidebar-mode = false;
        display-drun = " ";
        display-run = " ";
        display-window = " ";

        #adding vim keybindings
        kb-row-up = "Up,Control+k";
        kb-row-left = "Left,Control+h";
        kb-row-right = "Right,Control+l";
        kb-row-down = "Down,Control+j";

        kb-accept-entry = "Control+z,Control+y,Return,KP_Enter";

        #fixing up
        kb-remove-to-eol = "";
        kb-move-char-back = "Control+b";
        kb-remove-char-back = "BackSpace";
        kb-move-char-forward = "Control+f";
        kb-mode-complete = "Control+o";
      };
      theme = ./tokyonight_big1.rasi;
    };
  };
}
