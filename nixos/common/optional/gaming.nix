{ config, pkgs, lib, ... }:
{
  # steam doesn't work with home manager it seems
  config = {
    programs.steam.enable = true;
    programs.steam.extraPackages = with pkgs;[
      xorg.libXcursor
      xorg.libXi
      xorg.libXinerama
      xorg.libXScrnSaver
      xorg.xrandr
      libpng
      libpulseaudio
      libvorbis
      stdenv.cc.cc.lib
      libkrb5
      keyutils
      libva
      noto-fonts-cjk-sans
      noto-fonts
      vulkan-hdr-layer
    ];


    # services.hardware.openrgb = {
    #   enable = true;
    #   package = pkgs.openrgb-with-all-plugins;
    #   motherboard = "amd";
    # };
    # hardware.i2c.enable = true;

    programs.gamescope = {
      enable = true;
      package = pkgs.gamescope;
      capSysNice = false;
    };

    hardware.keyboard.qmk.enable = true;
    services.udev.packages = [ pkgs.via pkgs.openrgb-with-all-plugins ];

    services.ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-rules-cachyos;
    };

    environment.systemPackages = with pkgs; [
      mangohud
      prismlauncher
      protontricks
      steamtinkerlaunch
      heroic
      (lutris.override {
        extraPkgs = pkgs: [
          # List package dependencies here
          wine
          wine-staging
        ];
      })
      r2modman
      ludusavi
      via
      openrgb-with-all-plugins
      protonplus
      vulkan-hdr-layer
      scx.full
    ];
  };
}
