{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva
      libvdpau-va-gl
      vaapiVdpau
      rocmPackages.clr.icd
      # mesa # MAtlab can't find libgbm
    ];
  };
}
