{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (
    with pkgs;
    [
      gnome-console
      totem
      gnome-music
      gnome-tour
      gnome-software
    ]
  );
  environment.systemPackages =
    (with pkgs; [
      file-roller
      resources
      refine
      adw-gtk3
      qadwaitadecorations
      qadwaitadecorations-qt6
      decibels
      morewaita-icon-theme
      gnome-boxes
      # For better looking qt apps
      kdePackages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum
      kdePackages.qt6ct
      libsForQt5.qt5ct
      nautilus-python
      papers
      # nautilus-open-any-terminal
      ptyxis
      celluloid
      gnome-frog
      cava
    ])
    ++ (with pkgs.gnomeExtensions; [
      blur-my-shell
      (copyous.overrideAttrs (old: {
        buildInputs = [
          pkgs.libgda5
        ];
        preInstall =
          # bash
          ''
            sed -i "1i import GIRepository from 'gi://GIRepository';\nGIRepository.Repository.dup_default().prepend_search_path('${pkgs.libgda5}/lib/girepository-1.0');\nGIRepository.Repository.dup_default().prepend_search_path('${pkgs.gsound}/lib/girepository-1.0');\n" lib/preferences/dependencies/dependencies.js
            sed -i "1i import GIRepository from 'gi://GIRepository';\nGIRepository.Repository.dup_default().prepend_search_path('${pkgs.libgda5}/lib/girepository-1.0');\n" lib/database/entryTracker.js
            sed -i "1i import GIRepository from 'gi://GIRepository';\nGIRepository.Repository.dup_default().prepend_search_path('${pkgs.gsound}/lib/girepository-1.0');\n" lib/common/sound.js
            sed -i "1i import GIRepository from 'gi://GIRepository';\nGIRepository.Repository.dup_default().prepend_search_path('${pkgs.gsound}/lib/girepository-1.0');\n" lib/preferences/general/feedbackSettings.js
          '';
      }))
      pip-on-top
      caffeine
      appindicator
      tiling-assistant
      legacy-gtk3-theme-scheme-auto-switcher
      rounded-window-corners-reborn
      auto-power-profile
      power-off-options
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
  networking.networkmanager.wifi.powersave = true;

  xdg.terminal-exec.enable = true;

  # Nautilus Gstreamer is broken
  # https://github.com/NixOS/nixpkgs/issues/195936#issuecomment-1278954466
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 =
    lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0"
      [
        pkgs.gst_all_1.gst-plugins-good
        pkgs.gst_all_1.gst-plugins-bad
        pkgs.gst_all_1.gst-plugins-ugly
        pkgs.gst_all_1.gst-libav
      ];

  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      libpinyin
      # pkgs.ibus-speech-to-text
    ];
  };
  environment.variables.GTK_IM_MODULE = lib.mkForce "";

}
