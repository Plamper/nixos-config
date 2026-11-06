{ pkgs, ... }:
{

  nixpkgs.config.permittedInsecurePackages = [
    # zotero 10.0.4
    "firefox-esr-140-bin-unwrapped-140.17.0esr"
    "firefox-esr-140-bin-140.17.0esr"
  ];

  environment.systemPackages = with pkgs; [
    unstable.discord
    pika-backup
    imagemagick
    tutanota-desktop
    thunderbird
    anki-bin
    gimp3
    inkscape
    onlyoffice-desktopeditors
    rclone
    signal-desktop
    eyedropper
    parabolic
    rnote
    trayscale
    (pkgs.makeAutostartItem {
      name = "Trayscale";
      package = pkgs.trayscale;
      appendExtraArgs = [ "--hide-window" ];
      srcPrefix = "dev.deedles.";
    })
    # ktailctl
    # (pkgs.makeAutostartItem {
    #   name = "KTailctl";
    #   package = pkgs.ktailctl;
    #   srcPrefix = "org.fkoehler.";
    # })
    ffmpeg-full
    handbrake
    mkvtoolnix
    subtitleedit
    crosspipe
    jellyfin-media-player
    mediainfo
    audacity
    rclone
    lm_sensors
    xournalpp
    drawio
    easyeffects
    # jellyfin-mpv-shim
    komikku
    # portfolio
    bitwarden-desktop
    (pkgs.makeAutostartItem {
      name = "bitwarden";
      package = pkgs.bitwarden-desktop;
    })
    firefox
    fractal
    ausweisapp
    packet
    unstable.zed-editor
    planify
    solaar

    nextcloud-client

    typst
    touying
    tinymist
    typstyle

    adwaita-icon-theme # some apps look buggy without it
    unstable.zotero

    just
    cachix
    gitui
    unstable.antigravity-cli
    unstable.antigravity-ide
    unstable.antigravity-hub
    unstable.antigravity-acp

    # Man Pages
    man-pages
    man-pages-posix
    tldr

    # LDAC codec
    pulseaudioFull

    # Modern Images
    libheif
    libheif.out
    libavif
    libavif.out

    # often used commandline tools
    bubblewrap
    zip
    dig
    openssl
    appimage-run
  ];
  # For image thumbnails
  environment.pathsToLink = [ "share/thumbnailers" ];
}
