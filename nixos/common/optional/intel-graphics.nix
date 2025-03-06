{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva
      libvdpau-va-gl
      vaapiVdpau
      intel-vaapi-driver
      intel-media-driver
      vpl-gpu-rt
      mesa
    ];
  };
}
