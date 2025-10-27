# This file (and the global directory) holds config that i use on all hosts
{
  pkgs,
  inputs,
  outputs,
  ...
}:
{
  imports = [
    ./home-manager.nix
    ./nix.nix
    ./pipewire.nix
    # ./gnome.nix
    # ./kde.nix
    ./nix.nix
    ./shells.nix
    ./security.nix
    ./fonts.nix
    # ./ibus.nix
    #./fcitx5.nix
    ./distrobox.nix
    ./locale.nix
    ./nix-index.nix
    ./programs.nix
    ./gst.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      # outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure our nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # # Set your time zone.
  # time.timeZone = "Europe/Berlin";

  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    sbctl
  ];

  # boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  # boot.binfmt.preferStaticEmulators = true;

  # Enable Flatpak and Ratbagd
  services.flatpak.enable = true;

  # Be able to control wifi
  networking.wireless.userControlled.enable = true;
  services.tailscale.enable = true;


  networking.networkmanager.plugins = with pkgs;[
    networkmanager-openvpn
    networkmanager-openconnect
  ];

  # For firmware updates
  services.fwupd.enable = true;

  zramSwap.enable = true;

  programs.nix-ld.enable = true;

  services.btrfs.autoScrub.enable = true;
  services.fstrim.enable = true;

  # FPGA UDev Rules
  services.udev.extraRules = ''
    # USB Blaster
    SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6001", MODE="0666"

    # FTDI Bridge
    SUBSYSTEM=="usb", ATTR{idVendor}=="0403", ATTR{idProduct}=="6015", MODE="0666"
  '';

}
