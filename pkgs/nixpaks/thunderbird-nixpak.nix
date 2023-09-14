{ mkNixPak, thunderbird}:

# MANIFEST: https://github.com/flathub/org.mozilla.Thunderbird/blob/master/org.mozilla.Thunderbird.json#L13
mkNixPak {
  config = { sloth, pkgs, ... }: {

    app.package = thunderbird;

    dbus = {
      enable = true;
      policies = {
        "org.freedesktop.DBus" = "talk";
        "org.ally.Bus" = "talk";
        "org.freedesktop.Notifications" = "talk";
        "org.freedesktop.portal.*" = "talk";
        "org.mozilla.thunderbird_default.*" = "own";
      };
    };

    flatpak.appId = "org.mozilla.Thunderbird";

    etc.sslCertificates.enable = true;

    bubblewrap = {
      network = true;
      shareIpc = true;

      bind.rw = [
        # double check if this is necessary
        (sloth.env "XDG_RUNTIME_DIR")
        # TODO: can we just take the firefox subdirectory
        (sloth.concat' sloth.homeDir "/.mozilla")
        (sloth.concat' sloth.homeDir "/.thunderbird")
        #(sloth.concat' (sloth.env "XDG_CACHE_HOME") "/.mozilla")
        (sloth.concat' sloth.homeDir "/Downloads")
      ];
      bind.ro = [
        # (sloth.concat' sloth.homeDir "/Downloads")
        # TODO: replace with nixpak-specific font config?
        "/etc/fonts"

        # ???
        "/etc/resolv.conf"
      ];
      bind.dev = [
        # ???
        "/dev/dri"
      ];
    };
  };

}

