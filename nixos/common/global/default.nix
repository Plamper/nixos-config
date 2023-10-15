# This file (and the global directory) holds config that i use on all hosts
{ pkgs, outputs, ... }: {
  imports = [
    ./nix.nix
    ./pipewire.nix
    ./gnome.nix
    ./nix.nix
    ./shells.nix
    ./security.nix
    ./fonts.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

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

    # Enable Flatpak and Ratbagd
  services.flatpak.enable = true;
  services.ratbagd.enable = true;


  # Be able to control wifi
  networking.wireless.userControlled.enable = true;
  services.tailscale.enable = true;
  
  # Install android udev rules
  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  # For firmware updates
  services.fwupd.enable = true;
  
  # For Cachix
  nix.settings.trusted-users = [ "root" "felix" ];

  zramSwap.enable = true;
}
