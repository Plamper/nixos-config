{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      # sponsorblock
      # quality-menu
      # modernx-zydezu
      thumbfast
    ];
    config = {
      border = false;
      autofit= "40%";
      vo= "gpu-next";
      target-colorspace-hint= true;
      gpu-api= "vulkan";
      gpu-context= "waylandvk";
      keep-open = true;
    };
  };
}
