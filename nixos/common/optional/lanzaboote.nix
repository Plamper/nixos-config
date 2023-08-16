{ inputs, lib, ...}:
{
  imports = [
    # import lanzaboote
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # Change Bootloader to Lanzaboote for Secureboot
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.timeout = 0;
  
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
  
  boot.initrd.systemd.enable = true;
}
