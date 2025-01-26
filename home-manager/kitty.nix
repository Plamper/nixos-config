{ pkgs, ... }:
{
  config = {
    programs.kitty = {
      enable = true;
      font = {
        name = "JuliaMono Nerd Font";
        size = 13;
      };
      themeFile = "tokyo_night_moon";
      extraConfig = ''
        disable_ligatures always
      '';
    };
  };
}
