{ lib
, stdenv
, fetchFromGitHub
, meson
, pkg-config
, vulkan-loader
, ninja
, writeText
, vulkan-headers
, vulkan-utility-libraries
, jq
, libX11
, libXrandr
, libxcb
, wayland
, wayland-scanner
}:

stdenv.mkDerivation rec {
  pname = "vulkan-hdr-layer";
  version = "2799ab3";

  src = fetchFromGitHub {
    owner = "Zamundaaa";
    repo = "VK_hdr_layer";
    rev = "2799ab320b6d4cd43a493c2f3a6c4670d647171c";
    fetchSubmodules = true;
    hash = "sha256-MsvqxRYJO6eR7+Ntds8t6pb+XFEjfT8S6rq+Wha/FHk=";
  };

  nativeBuildInputs = [ vulkan-headers meson ninja pkg-config jq ];

  buildInputs = [ vulkan-headers vulkan-loader vulkan-utility-libraries libX11 libXrandr libxcb wayland wayland-scanner ];

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
