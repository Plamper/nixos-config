{
  stdenv,
  fetchFromGitHub,
  fetchzip,
  vapoursynth,
  pkg-config,
  cmake,
  shaderc, 
  glslang,
  vulkan-headers, 
  vulkan-loader,
  ncnn
}:
stdenv.mkDerivation {
  pname = "VapourSynth-RealCUGAN-ncnn-Vulkan";
  version = "git";

  src = fetchFromGitHub {
    owner = "Tatsh";
    repo = "VapourSynth-Real-ESRGAN-ncnn-vulkan";  
    rev = "731633e6ac3d4e48476b64f2f77a006148913d25";
    sha256 = "sha256-ZNPhnsKyuWqWULa9+UKPvSKo7Olt4ocrfuxmod0nWnU=";
  };
  sourceRoot = "source/src";


  models = fetchzip {
    url = "https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.5.0/realesrgan-ncnn-vulkan-20220424-ubuntu.zip";
    stripRoot = false;
    sha256 = "sha256-1YiPzv1eGnHrazJFRvl37+C1F2xnoEbN0UQYkxLT+JQ=";
  };

  cmakeFlags = [
    "-DVAPOURSYNTH_INCLUDE_DIR=${vapoursynth}/include/vapoursynth"
  ];

  patches = [
    ./cmakelists.patch
  ];


  nativeBuildInputs = [
    pkg-config
    cmake
  ];
  buildInputs = [
    vapoursynth
    shaderc
    glslang
    vulkan-headers 
    vulkan-loader
    ncnn
  ];

  installPhase = ''
    mkdir -p $out/lib/vapoursynth/models
    cp librealesrgan.so $out/lib/vapoursynth/  
    cp -r $models/models/* $out/lib/vapoursynth/models
  '';
}
