{ inputs, pkgs, lib, ... }:
{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverridePackages = [ pkgs.mutter ];
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['scale-monitor-framebuffer', 'variable-refresh-rate']
    '';
  };
  environment.gnome.excludePackages = (with pkgs; [
    gnome-console
    totem
    gnome-music
    gnome-tour
  ]);
  environment.systemPackages = (with pkgs; [
    gnome-tweaks
    adw-gtk3
    qadwaitadecorations
    qadwaitadecorations-qt6
    unstable.morewaita-icon-theme
    # For better looking qt apps
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qt6ct
    libsForQt5.qt5ct
    nautilus-python
    papers
    # nautilus-open-any-terminal
    ptyxis
    pika-backup
    celluloid
    libreoffice
    ghostty
    (pkgs.writeShellApplication {
      name = "xdg-terminal-exec";

      runtimeInputs = [ pkgs.ghostty ];

      text = ''
        ghostty -e "$*"
      '';
    })
  ]) ++ (with pkgs.gnomeExtensions; [
    easyeffects-preset-selector
    blur-my-shell
    pano
    bing-wallpaper-changer
    caffeine
    appindicator
    tiling-assistant
    alphabetical-app-grid
    legacy-gtk3-theme-scheme-auto-switcher
    rounded-window-corners-reborn
    hibernate-status-button
  ]);

  # programs.dconf = {
  #   enable = true;
  #   profiles.user.databases = [{
  #     settings."com/github/stunkymonkey/nautilus-open-any-terminal".terminal = "ghostty";
  #     lockAll = true;
  #   }];
  # };

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
  networking.networkmanager.wifi.powersave = true;

  # Nautilus Gstreamer is broken
  # https://github.com/NixOS/nixpkgs/issues/195936#issuecomment-1278954466
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" [
    pkgs.gst_all_1.gst-plugins-good
    pkgs.gst_all_1.gst-plugins-bad
    pkgs.gst_all_1.gst-plugins-ugly
    pkgs.gst_all_1.gst-libav
  ];
}
