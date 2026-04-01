{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  config = {
    services.mpd = {
      enable = true;
      musicDirectory = "~/Music";
      # playlistDirectory = "~/Music/Playlists";
      extraConfig = ''
        audio_output {  
          type	"pipewire" #
          name  "Pipewire"  #
          dsd         "yes"  #
          # replay_gain_handler "mixer"
        }

        replaygain          "auto"
        # replaygain_preamp "13"
      '';
    };
    # services.mpd-mpris.enable = true;

    programs.beets = {
      enable = false;
      package = pkgs.python3.pkgs.beets.override {
        pluginOverrides = {
          alternatives = {
            enable = true;
            propagatedBuildInputs = [ pkgs.python3Packages.beets-alternatives ];
          };
        };
      };
      # mpdIntegration.enableStats = true;
      # mpdIntegration.enableUpdate = true;
      settings = {
        import.move = true;
        directory = "~/Music";
        library = "~/.config/beets/musiclibrary.db";
        plugins = "web replaygain chroma fetchart embedart thumbnails edit discogs lyrics alternatives convert fish mpdstats mpdupdate playlist";

        fetchart.sources = "filesystem itunes amazon lastfm wikipedia coverart albumart";

        replaygain.backend = "ffmpeg";

        mpd = {
          host = "localhost";
          port = 6600;
        };

        playlist = {
          auto = true;
          relative_to = "~/Music";
          playlist_dir = "~/Music/Playlists";
        };

        alternatives = {
          walkman = {
            directory = "/run/media/felix/WALKMAN";
            paths.default = "MUSIC/$albumartist/$album/$title";
            formats = "aac mp3 flac wav";
            query = "walkman:true";
            removable = "true";
          };
          garmin = {
            directory = "/run/user/1000/gvfs/mtp:host=091e_50db_0000d859b119/Internal\ Storage/Music";
            paths.default = "MUSIC/$albumartist/$album/$title";
            formats = "aac";
            query = "garmin:true";
            removable = "true";
          };
        };
      };
    };
  };
}
