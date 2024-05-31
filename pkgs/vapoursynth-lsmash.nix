{ stdenv, fetchFromGitHub, pkg-config, which, vapoursynth, ffmpeg_4, l-smash, meson, ninja}:

stdenv.mkDerivation {
  pname = "lsmashsource";
  version = "git"; # last (only) release is from 2013 and there has still been development

  src = fetchFromGitHub {
    owner = "AkarinVS";
    repo = "L-SMASH-Works";
    rev = "024ac718bca701e9175f663cbfd6589fc0c27fdb";
    sha256 = "sha256-elcuYPICYoxBflVdAIQECXCZ5LPX1zWC25MRJZWPObM=";
  };

  preConfigure = ''
    patchShebangs .
    cd VapourSynth
  '';

  nativeBuildInputs = [ meson ninja pkg-config which ];
  buildInputs = [ vapoursynth ffmpeg_4 l-smash ];

  installPhase = ''
    mkdir -p $out/lib/vapoursynth/
    cp libvslsmashsource.so $out/lib/vapoursynth/
  '';
  
  meta = {
    description = "L-SMASH source plugin for VapourSynth";
    homepage = "https://github.com/AkarinVS/L-SMASH-Works";
  };
}
