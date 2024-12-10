# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ inputs, outputs, config, pkgs, ... }:

{
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ../common/global
    ../common/users/felix.nix
    ../common/optional/lanzaboote.nix
    #../common/optional/waydroid.nix
    ../common/optional/printing.nix
    # ../common/optional/virt-manager.nix
    ../common/optional/amd-graphics.nix
    ../common/optional/matlab.nix
    ../common/optional/gnome.nix
    ../common/optional/ibus.nix
  ];

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # active has some brightness issues somehow
  boot.kernelParams = [ "amd_pstate=active" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # TODO: Set your hostname
  networking.hostName = "notebook";


  boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.plymouth.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}

