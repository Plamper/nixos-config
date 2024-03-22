{ pkgs, inputs, ...}:
{
  
  config = {
    nixpkgs.overlays = [
      inputs.vs-overlay.overlay
    ];
    home.packages =     
    let 
      vapour =  
        pkgs.vapoursynth.withPlugins [
          pkgs.vapoursynth-lsmash
          pkgs.ffms
          pkgs.vapoursynthPlugins.havsfunc 
          pkgs.vapoursynthPlugins.fmtconv
          pkgs.real-cugan
          pkgs.vapoursynth-realesrgan-nccnn-vulkan  
        ];    
      
      libaom = pkgs.libaom.overrideAttrs (prevAttrs: {
        version = "git";

        src = pkgs.fetchFromGitHub {
          owner = "Clybius";
          repo = "aom-av1-lavish";
          rev = "83500ccf39c98e4688acda163f87c12d8b1a854a";
          sha256 = "sha256-Ry5Uk/WTawx7Grp1J63I4heTY9kKBztNIRI6/0LWQDg=";
        };
      });
    in with pkgs;
     [
      (av1an.override { vapoursynth = vapour ;})
      # pkgs.unstable.svt-av1
      svt-av1-psy
      libaom
      opusTools
      flac
      ffmpeg-full
      handbrake
      mkvtoolnix
      subtitleedit
      vapour
      (vapoursynth-editor.withPlugins [
        vapoursynthPlugins.havsfunc 
        pkgs.ffms
        pkgs.real-cugan
        pkgs.vapoursynthPlugins.fmtconv
        pkgs.vapoursynth-realesrgan-nccnn-vulkan  
     ])
    ];
  };
}
