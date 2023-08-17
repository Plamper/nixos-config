{ pkgs, ...}:
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
}