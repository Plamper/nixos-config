{ pkgs, lib, ...}:
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

  # Nautilus Gstreamer is broken
  # https://github.com/NixOS/nixpkgs/issues/195936#issuecomment-1278954466
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" [
    pkgs.gst_all_1.gst-plugins-good
    pkgs.gst_all_1.gst-plugins-bad
    pkgs.gst_all_1.gst-plugins-ugly
    pkgs.gst_all_1.gst-plugins-libav
  ];
}
