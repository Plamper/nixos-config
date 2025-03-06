{ inputs, lib, ... }:
{
  imports = [
    # import lanzaboote
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # Force disable Systemd-Boot for Lanzaboote
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;
  # Fix resolution for console
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.timeout = 0;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

  # Plymouth Fixes
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;
  boot.kernelParams = [ "quiet" ];
}
