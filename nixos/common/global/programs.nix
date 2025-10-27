{ pkgs, ... }:
{

  # Jellyfin media client
  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
  ];

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
    libreoffice-fresh
    rclone
    signal-desktop
    eyedropper
    # tidal-hifi
    discord
    (pkgs.makeAutostartItem {
      name = "discord";
      package = pkgs.discord;
      appendExtraArgs = [ "--start-minimized" ];
    })
    mission-center
    rnote
    trayscale
    (pkgs.makeAutostartItem {
      name = "Trayscale";
      package = pkgs.trayscale;
      appendExtraArgs = [ "--hide-window" ];
      srcPrefix = "dev.deedles.";
    })
    ffmpeg-full
    handbrake
    mkvtoolnix
    subtitleedit
    helvum
    # jellyfin-media-player
    mediainfo
    audacity
    rclone
    lm_sensors
    xournalpp
    drawio
    easyeffects
    jellyfin-mpv-shim
    kdePackages.kdenlive
    frei0r
    komikku
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


    # Modern Images
    libheif
    libheif.out
    libavif
    libavif.out
  ];
  # For image thumbnails
  environment.pathsToLink = [ "share/thumbnailers" ];
}
