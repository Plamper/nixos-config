{ inputs, pkgs, lib, ... }:
{
  services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Force password on loginmanager
  # Fixes kde wallet unlock
  security.pam.services.login.fprintAuth = false;

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id.indexOf("net.reactivated.fprint.") > -1) {
        return polkit.Result.YES;
      }
    });
  '';

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = true;
  services.power-profiles-daemon.enable = true;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Install not included packages
  environment.systemPackages = with pkgs; [
    kdePackages.partitionmanager
    kdePackages.kio-fuse # to mount remote filesystems via FUSE
    kdePackages.kio-extras # extra protocols support (sftp, fish and more)
    maliit-keyboard
    kara
  ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        qt6Packages.fcitx5-chinese-addons
        fcitx5-table-extra
        fcitx5-chewing
      ];
    };
  };
  environment.variables.GTK_IM_MODULE = lib.mkForce "";
}
