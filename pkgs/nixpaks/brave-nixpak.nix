# MANIFEST: https://github.com/flathub/com.brave.Browser/blob/master/com.brave.Browser.yaml

{ mkNixPak, brave, ...}:
mkNixPak {
  config = { sloth, ... }: {

    app.package = brave;

    dbus = {
      enable = true;
      policies = {
        # should be system-talk
        # SEE: https://github.com/nixpak/nixpak/issues/6
        "org.freedesktop.Avahi" = "talk";
        "org.freedesktop.UPower" = "talk";

        "org.gnome.Mutter.IdleMonitor.*" = "talk";
        "org.freedesktop.FileManager1" = "talk";
        "org.freedesktop.Notifications" = "talk";
        "org.freedesktop.ScreenSaver" = "talk";
        "org.freedesktop.secrets" = "talk";
        "org.kde.kwalletd5" = "talk";
        "org.gnome.SessionManager" = "talk";
        "org.mpris.MediaPlayer2.brave.*" = "own";
        "org.gnome.desktop.interface.*" = "talk";

        # not in manifest, but will use filepicker
        "org.freedesktop.portal.*" = "talk";
      };
    };

    flatpak.appId = "com.brave.Browser";

    etc.sslCertificates.enable = true;

    bubblewrap = {
      network = true;
      shareIpc = true;

      # so it can create a socket
      tmpfs = [ "/tmp" ];

      bind.rw = [
        # double check if this is necessary
        (sloth.env "XDG_RUNTIME_DIR")
        (sloth.concat' (sloth.env "XDG_CONFIG_HOME") "/BraveSoftware")
        (sloth.concat' (sloth.env "XDG_CACHE_HOME") "/BraveSoftware")
        (sloth.concat' sloth.homeDir "/Downloads")

        # Brave complains if i don't add these
        "/run/dbus/system_bus_socket"
        "/run/current-system/sw/bin/readlink"
        "/run/current-system/sw/bin/mkdir"
        "/run/current-system/sw/bin/dirname"
        "/run/current-system/sw/bin/touch"
        "/run/current-system/sw/bin/cat"

        (sloth.concat' sloth.homeDir ".local/share/applications")
        (sloth.concat' sloth.homeDir ".local/share/icons")
      ];
      bind.ro = [
        # TODO: replace with nixpak-specific font config?
        "/etc/fonts"

        # Needed for internet access
        "/etc/resolv.conf"

        (sloth.concat' (sloth.env "XDG_CONFIG_HOME") "/dconf")

        # pulseaudio socket
        # is this necessary? we already bind a containing directory rw
        (sloth.concat' (sloth.env "XDG_RUNTIME_DIR") "/pulse/native")

        # maybe needed for anything configured by home manager
        # (sloth.concat' sloth.homeDir "/.nix-profile")

      ];

      sockets = {
        wayland = true;
        pipewire = true;
        pulse = true;
      };

      env = {
        
      };
    };

    gpu.enable = true;

    fonts.enable = true;
  };
}
