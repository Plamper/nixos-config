{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libva
      libvdpau-va-gl
      vaapiVdpau
      mesa # MAtlab can't find libgbm
    ];
  };
}
