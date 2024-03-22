{ config, pkgs, ... }:
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
      ];
  };
    
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
    ];
  };
}
