{ pkgs, ... }:
{
  config = {
    programs.kitty = {
      enable = true;
      font = {
        name = "FiraCode Nerd Font";
        size = 13;
      };
      theme = "Tokyo Night Storm";
      extraConfig = ''
        background_opacity 0.85
      '';
    };
  };
}
