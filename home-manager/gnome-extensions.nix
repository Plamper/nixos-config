{ pkgs, ... }:
{
  config = {
    home.packages = with pkgs.gnomeExtensions; [

      # Gnome Extensions
      pano
      blur-my-shell
      bing-wallpaper-changer
      caffeine
      appindicator
      # rounded-window-corners
      tiling-assistant
      alphabetical-app-grid
      legacy-gtk3-theme-scheme-auto-switcher
      syncthing-indicator
    ];
  };
}
