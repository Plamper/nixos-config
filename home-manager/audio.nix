{ inputs, outputs, lib, config, pkgs, ... }: {
  config = {
    services.mpd = {
      enable = true;
      musicDirectory = "~/Music";
      extraConfig = '' 
        audio_output {  
          type	"pipewire" #
          name  "Pipewire"  #
          dsd         "yes"  #
        }
     '';
    };
    services.mpd-mpris.enable = true;

    programs.beets = {
      enable = true;
      package = pkgs.beets.override {
        pluginOverrides = {
          # Copied from https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/tools/audio/beets/default.nix
          alternatives = {
            enable = true;
            propagatedBuildInputs = [ pkgs.beetsPackages.alternatives ];
          };
        };
      };
      # mpdIntegration.enableStats = true;
      # mpdIntegration.enableUpdate = true;
      settings = {
        directory = "~/Music";
        library = "~/Music/musiclibrary.db";
        plugins = "chroma fetchart embedart thumbnails edit discogs lyrics alternatives convert fish mpdstats mpdupdate";

        fetchart.sources = "filesystem itunes amazon lastfm wikipedia coverart albumart";

        mpd = {
          host = "localhost";
          port = 6600;
        };

        alternatives = {
          walkman = {
            directory = "/run/media/felix/WALKMAN";
            paths.default = "MUSIC/$albumartist/$album/$title";
            formats = "aac mp3 flac wav";
            query = "walkman:true";
            removable = "true";
          };
        };
      };
    };
  };
}
