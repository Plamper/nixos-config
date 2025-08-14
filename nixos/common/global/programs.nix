{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    imagemagick
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
    # tidal-hifi
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
    xournalpp
    drawio
    easyeffects
    jellyfin-mpv-shim
    # darktable
    kdePackages.kdenlive
    frei0r
    # portfolio
    bitwarden-desktop
    firefox
    fractal
    ausweisapp
    high-tide
    packet
    zed-editor
    planify

    nextcloud-client

    typst
    tinymist
    typstyle

    adwaita-icon-theme # some apps look buggy without it
    zotero

    just
    cachix
    gitui

    # Man Pages
    man-pages
    man-pages-posix
    tldr
  ];
}
