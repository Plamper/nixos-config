{ pkgs, lib, ... }:
{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
    gnome-console
    gnome.totem
    gnome.gnome-music
    gnome-tour
  ]);
  environment.systemPackages = (with pkgs; [
    gnome.gnome-tweaks
    adw-gtk3
    qadwaitadecorations
    qadwaitadecorations-qt6
    ptyxis
    morewaita-icon-theme
    # For better looking qt apps
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qt6ct
    libsForQt5.qt5ct
    unstable.gnomeExtensions.blur-my-shell
    gnome.nautilus-python
    unstable.papers
  ]) ++ (with pkgs.gnomeExtensions; [
    pano
    bing-wallpaper-changer
    caffeine
    appindicator
    # rounded-window-corners
    tiling-assistant
    alphabetical-app-grid
    legacy-gtk3-theme-scheme-auto-switcher
  ]);

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_STYLE_OVERRIDE = "kvantum";
    QT_WAYLAND_DECORATION = "adwaita";
    # Kinda bugged with qt apps this fixes it
    XCURSOR_THEME = "Adwaita";
  };

  qt.style = "kvantum";

  services.power-profiles-daemon.enable = true;
  networking.networkmanager.enable = true;

  # Nautilus Gstreamer is broken
  # https://github.com/NixOS/nixpkgs/issues/195936#issuecomment-1278954466
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" [
    pkgs.gst_all_1.gst-plugins-good
    pkgs.gst_all_1.gst-plugins-bad
    pkgs.gst_all_1.gst-plugins-ugly
    pkgs.gst_all_1.gst-libav
  ];
}
