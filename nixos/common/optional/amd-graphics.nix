{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva
      libvdpau-va-gl
      libva-vdpau-driver
      rocmPackages.clr.icd
      # mesa # MAtlab can't find libgbm
    ];
  };
}
