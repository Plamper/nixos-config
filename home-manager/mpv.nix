{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      sponsorblock
      quality-menu
      uosc
      thumbfast
    ];
    config = {
      border = false;
      autofit= "40%";
    };
  };
}
