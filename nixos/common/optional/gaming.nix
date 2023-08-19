{ config, pkgs, ...}:
{
  # steam doesn't work with home manager it seems
  config = {
    programs.steam.enable = true;
    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      mangohud
      gamescope
      prismlauncher
    ];
  };
}
