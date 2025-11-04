{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva
      libvdpau-va-gl
      libva-vdpau-driver
      intel-vaapi-driver
      intel-media-driver
      intel-compute-runtime
      vpl-gpu-rt
      # mesa
    ];
  };
}
