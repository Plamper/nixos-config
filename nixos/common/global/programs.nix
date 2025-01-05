{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    imagemagick
    # For editing pdfs with imagemagick
    plattenalbum
    tutanota-desktop
    thunderbird-128
    anki-bin
    element-desktop
    gimp
    inkscape
    onlyoffice-desktopeditors
    signal-desktop
    eyedropper
    nvtopPackages.amd
    tidal-hifi
    # vesktop
    mission-center
    # (pkgs.makeAutostartItem { name = "vesktop"; package = pkgs.unstable.vesktop; })
    rnote
    trayscale
    ffmpeg-full
    handbrake
    mkvtoolnix
    subtitleedit
    helvum
    jellyfin-media-player
    mediainfo
    audacity
    rclone
    lm_sensors
    jamesdsp
    xournalpp
    drawio
    easyeffects
    jellyfin-mpv-shim
    darktable
    kdenlive

    seafile-client
    nextcloud-client

    typst
    tinymist


    adwaita-icon-theme # some apps look buggy without it
    bibata-cursors
    libreoffice

    # dev stuff
    just
    cachix
    gitui

    nodejs
    # Man Pages
    man-pages
    man-pages-posix
    tldr
  ];
}
