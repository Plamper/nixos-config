{ inputs, pkgs, ... }:
{
  # You may need to comment out "services.displayManager.gdm.enable = true;"
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  # services.displayManager.sddm.wayland.enable = true;

  # needed because bugged currently
  # services.gnome.gnome-keyring.enable = true;
  # security.pam.services.sddm.enableGnomeKeyring = true;
  networking.networkmanager.enable = true;
  services.power-profiles-daemon.enable = true;
  xdg.portal = { enable = true; xdgOpenUsePortal = true; };

  # Install not included packages
  environment.systemPackages = with pkgs; [
    kdePackages.partitionmanager
    vorta
    libreoffice-qt
    kdePackages.kio-fuse #to mount remote filesystems via FUSE
    kdePackages.kio-extras #extra protocols support (sftp, fish and more)
    kitty
  ];
}
