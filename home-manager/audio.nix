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

        
        audio_output {  
          type	"alsa" #
          name  "Alsa"  #
          mixer_type "hardware"
          mixer_control "E30 "
          mixer_device "hw:1"
          device "hw:1"
          replay_gain_handler "mixer"
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
        import.move = true;
        directory = "~/Music";
        library = "~/.config/beets/musiclibrary.db";
        plugins = "web replaygain chroma fetchart embedart thumbnails edit discogs lyrics alternatives convert fish mpdstats mpdupdate";

        fetchart.sources = "filesystem itunes amazon lastfm wikipedia coverart albumart";

        replaygain.backend = "ffmpeg";       

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
