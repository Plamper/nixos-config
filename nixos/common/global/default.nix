# This file (and the global directory) holds config that i use on all hosts
{ pkgs, inputs, outputs, ... }: {
  imports = [
    ./home-manager.nix
    ./nix.nix
    ./pipewire.nix
    ./gnome.nix
    # ./kde.nix
    ./nix.nix
    ./shells.nix
    ./security.nix
    ./fonts.nix
    ./ibus.nix
    #./fcitx5.nix
    ./distrobox.nix
    ./locale.nix
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

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git
    sbctl
    piper
  ];


  # Enable Flatpak and Ratbagd
  services.flatpak.enable = true;
  services.ratbagd.enable = true;

  programs.command-not-found.dbPath = inputs.programsdb.packages.${pkgs.system}.programs-sqlite;

  # Be able to control wifi
  networking.wireless.userControlled.enable = true;
  services.tailscale.enable = true;

  # Install android udev rules
  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  # For firmware updates
  services.fwupd.enable = true;



  zramSwap.enable = true;

  programs.nix-ld.enable = true;
}
