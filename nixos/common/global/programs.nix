{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    imagemagick
    # For editing pdfs with imagemagick
    plattenalbum
    tutanota-desktop
    thunderbird
    anki-bin
    element-desktop
    gimp3
    inkscape
    onlyoffice-desktopeditors
    signal-desktop
    eyedropper
    nvtopPackages.amd
    tidal-hifi
    discord
    (pkgs.makeAutostartItem {
      name = "discord";
      package = pkgs.discord;
    })
    mission-center
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
    kdePackages.kdenlive
    frei0r
    # portfolio
    bitwarden-desktop
    firefox
    # unstable.alpaca
    fractal
    ausweisapp

    seafile-client
    nextcloud-client

    typst
    tinymist
    typstyle

    adwaita-icon-theme # some apps look buggy without it
    bibata-cursors
    zotero

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
