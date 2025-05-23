# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usb_storage"
    "sd_mod"
    "sdhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/bdb64da7-779d-42d8-a2e8-a21b802688aa";
    fsType = "btrfs";
    options = [
      "subvol=@root"
      "compress=zstd:2"
    ];
  };

  boot.initrd.luks.devices = {
    "root" = {
      device = "/dev/disk/by-uuid/9e0af774-d557-41b4-84cf-b3231106e5ca";
      bypassWorkqueues = true;
      allowDiscards = true;
    };
    "swap" = {
      device = "/dev/disk/by-uuid/82e4290b-3abc-4fae-a1e3-560bb589ccef";
      bypassWorkqueues = true;
      allowDiscards = false;
    };
  };
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/bdb64da7-779d-42d8-a2e8-a21b802688aa";
    fsType = "btrfs";
    options = [
      "subvol=@home"
      "compress=zstd:2"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/bdb64da7-779d-42d8-a2e8-a21b802688aa";
    fsType = "btrfs";
    options = [
      "subvol=@nix-store"
      "compress=zstd:2"
      "noatime"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/1B07-A262";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/aa390474-f83c-41d9-b275-33c1ac651cbf";
      priority = 1;
    }
  ];

  boot.resumeDevice = "/dev/disk/by-uuid/aa390474-f83c-41d9-b275-33c1ac651cbf";

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s13f0u1u4c2.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
