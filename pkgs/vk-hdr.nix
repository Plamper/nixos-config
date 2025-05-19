{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  pkg-config,
  vulkan-loader,
  ninja,
  writeText,
  vulkan-headers,
  vulkan-utility-libraries,
  jq,
  libX11,
  libXrandr,
  libxcb,
  wayland,
  wayland-scanner,
}:

stdenv.mkDerivation rec {
  pname = "vulkan-hdr-layer";
  version = "2799ab3";

  src = fetchFromGitHub {
    owner = "Zamundaaa";
    repo = "VK_hdr_layer";
    rev = "3b276e68136eb10825aa7cabd06abb324897f0e8";
    fetchSubmodules = true;
    hash = "sha256-c3OLT2qMKAQnQYrTVhrs3BEVS55HoaeBijgzygz6zgs=";
  };

  nativeBuildInputs = [
    vulkan-headers
    meson
    ninja
    pkg-config
    jq
  ];

  buildInputs = [
    vulkan-headers
    vulkan-loader
    vulkan-utility-libraries
    libX11
    libXrandr
    libxcb
    wayland
    wayland-scanner
  ];

  # Help vulkan-loader find the validation layers
  setupHook = writeText "setup-hook" ''
    addToSearchPath XDG_DATA_DIRS @out@/share
  '';

  meta = with lib; {
    description = "Layers providing Vulkan HDR";
    homepage = "https://github.com/Zamundaaa/VK_hdr_layer";
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
