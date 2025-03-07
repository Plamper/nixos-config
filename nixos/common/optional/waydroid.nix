{ config, pkgs, ... }:
{
  config = {
    virtualisation.waydroid.enable = true;
    environment.systemPackages = with pkgs; [
      wl-clipboard
    ];
  };
}
