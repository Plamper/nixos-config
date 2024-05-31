{
  fetchFromGitHub,
  vapoursynth,
  pkg-config,
  stdenv,
  cmake,
  vulkan-headers,
  vulkan-loader,
  glslang,
  shaderc,
  ncnn,
  fetchzip
}:
stdenv.mkDerivation {
  pname = "VapourSynth-RealCUGAN-ncnn-Vulkan";
  version = "git";

  src = fetchFromGitHub {
    owner = "Kiyamou";
    repo = "VapourSynth-RealCUGAN-ncnn-Vulkan";
    rev = "4db9493b12aab1eb089db6537d20e7872efae9c0";
    sha256 = "sha256-TOoN5yXwBZ/EiAQaDMv0xzKY3GUmArQw7eH6kYrVFHM=";
  };

  models = fetchzip {
    url = "https://github.com/Kiyamou/VapourSynth-RealCUGAN-ncnn-Vulkan/releases/download/r2/models.zip";
    stripRoot = true;
    sha256 = "sha256-Gcz+ABG+3S2YOplZ/A2nA0uMaJZNEB67Zi0z/5JGJfE=";
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
    cp librealcugannv.so $out/lib/vapoursynth/  
    cp -r $models/* $out/lib/vapoursynth/models
  '';
}
