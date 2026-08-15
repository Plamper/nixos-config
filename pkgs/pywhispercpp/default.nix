{ fetchFromGitHub
, cmake
, python3Packages
, whisper-cpp-vulkan
}:

python3Packages.buildPythonPackage {
  pname = "pywhispercpp";
  version = "1.5.0-unstable-2026-08-11";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "absadiki";
    repo = "pywhispercpp";
    rev = "main";
    hash = "sha256-I0bpMQZWc+reyX5agD16ygvjKPIZFoABF2ZBHRwCefs=";
  };

  postPatch = ''
    substituteInPlace CMakeLists.txt \
      --replace-fail 'add_subdirectory(pybind11)' 'find_package(pybind11 CONFIG REQUIRED)' \
      --replace-fail 'add_subdirectory(whisper.cpp)' 'find_package(whisper CONFIG REQUIRED)'

    sed -i '/^#include "whisper.h"$/a #include "ggml-backend.h"' src/main.cpp
    sed -i '/^PYBIND11_MODULE(_pywhispercpp, m) {$/a\    ggml_backend_load_all();' src/main.cpp
  '';

  nativeBuildInputs = [
    cmake
    python3Packages.setuptools
    python3Packages.wheel
    python3Packages.pybind11
  ];

  buildInputs = [ whisper-cpp-vulkan ];
  dependencies = with python3Packages; [ numpy requests tqdm platformdirs ];

  dontUseCmakeConfigure = true;
  CMAKE_ARGS = "-DCMAKE_PREFIX_PATH=${whisper-cpp-vulkan}";

  # The upstream setup.py forwards all environment variables to CMake.
  GGML_VULKAN = "1";
  NO_REPAIR = "1";

  doCheck = false;
}
