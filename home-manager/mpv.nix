{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      # sponsorblock
      # quality-menu
      # modernx-zydezu
      thumbfast
      mpris
      uosc
    ];
    config = {
      border = false;
      # vidscale = false;
      # scalewindowed = 2.0;
      # scalefullscreen = 2.0;
      vo = "gpu-next";
      target-colorspace-hint = true;
      gpu-api = "vulkan";
      gpu-context = "waylandvk";
      hwdec = "auto";
      osd-font="Adwaita Sans";
      keep-open = true;
    };
  };
  # home.file.".config/mpv/script-opts/modernx.conf".text =
  #   # conf
  #   ''
  #     show_chapter_markers=true
  #     scale_windowed=2.0
  #     scale_fullscreen=2.0   
  #   '';
}
