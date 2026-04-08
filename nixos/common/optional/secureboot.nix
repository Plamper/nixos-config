{ inputs, lib, ... }:
{

  boot.loader.limine = {
    enable = true;
    secureBoot.enable = true;
    maxGenerations = 50;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;

  # Plymouth Fixes
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;
  boot.kernelParams = [ "quiet" ];
}
