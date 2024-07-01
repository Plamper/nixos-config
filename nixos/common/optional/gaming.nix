{ config, pkgs, lib, ... }:
{
  # steam doesn't work with home manager it seems
  config = {
    nixpkgs.config.permittedInsecurePackages = [
      "electron-25.9.0"
    ];
    programs.steam.enable = true;
    programs.steam.package = pkgs.steam.override {
      # Gamescope workaround
      extraPkgs = pkgs: with pkgs;[
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
        libva
        gamescope
        gamemode
      ];
    };

    # services.hardware.openrgb = {
    #   enable = true;
    #   package = pkgs.openrgb-with-all-plugins;
    #   motherboard = "amd";
    # };
    # hardware.i2c.enable = true;

    hardware.keyboard.qmk.enable = true;
    services.udev.packages = [ pkgs.via pkgs.openrgb-with-all-plugins ];

    programs.gamescope.enable = true;

    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      mangohud
      unstable.prismlauncher
      protontricks
      steamtinkerlaunch
      unstable.heroic
      (lutris.override {
        extraPkgs = pkgs: [
          # List package dependencies here
          wine
          wine-staging
        ];
      })
      unstable.r2modman
      unstable.ludusavi
      via
      openrgb-with-all-plugins
    ];
  };
}
