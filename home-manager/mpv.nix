{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      sponsorblock
      quality-menu
      modernx-zydezu
      thumbfast
    ];
    config = {
      border = false;
      autofit= "40%";
    };
  };
}
