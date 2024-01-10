{ config, pkgs, ... }:
{
  # steam doesn't work with home manager it seems
  config = {
    nixpkgs.config.permittedInsecurePackages = [
      "electron-25.9.0"
    ];
    programs.steam.enable = true;
    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      mangohud
      gamescope
      prismlauncher
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
