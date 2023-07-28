# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/71d04fb4-9e47-476a-9a35-3ce6345a944b";
      fsType = "btrfs";
      options = [ "subvol=root" 
      		  "compress=zstd"
      		];
    };

  boot.initrd.luks.devices."luks-b4bc9ade-4587-4eeb-bc30-67dc80cf417d".device = "/dev/disk/by-uuid/b4bc9ade-4587-4eeb-bc30-67dc80cf417d";

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/71d04fb4-9e47-476a-9a35-3ce6345a944b";
      fsType = "btrfs";
      options = [ "subvol=home" 
		  "compress=zstd"
		];
    };

  fileSystems."/var" =
    { device = "/dev/disk/by-uuid/71d04fb4-9e47-476a-9a35-3ce6345a944b";
      fsType = "btrfs";
      options = [ "subvol=var" 
      		  "compress=zstd"
      		];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/71d04fb4-9e47-476a-9a35-3ce6345a944b";
      fsType = "btrfs";
      options = [ "subvol=nix-store"
      		  "compress=zstd"
      		  "noatime"
      		];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/0dd4743a-d9a7-449b-8eaf-2976dcba0367";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/FDF4-2A67";
      fsType = "vfat";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp34s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
