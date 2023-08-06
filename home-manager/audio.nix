{ inputs, outputs, lib, config, pkgs, ... }: {
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
    mpdIntegration.enableStats = true;
    mpdIntegration.enableUpdate = true;
    settings = {
      directory = "~/Music";
      library =  "~/Music/musiclibrary.db";
      plugins = "chroma fetchart embedart thumbnails edit discogs convert lyrics";

      fetchart.sources = "filesystem itunes amazon lastfm wikipedia coverart albumart";
  
      convert.no_convert = "format:flac format:mp3 format:AAC";
    }
  }
}