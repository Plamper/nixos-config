{
  lib,
  fetchFromGitHub,
  rustPlatform,
  vapoursynth,
  ffmpeg,
  x264,
  libaom,
  rav1e,
  nasm,
  pkg-config,
  python3,
  python3Packages,
  makeWrapper
}:
let
  pname = "av1an";
  version = "0.4.2";

  sha256 = "sha256-A4/1UdM8N5CHP44PBNB+ZH2Gcl84rcpUBwQRSnubBGc=";

  cargoHash = "sha256-+ipS2j09ssCJEZLWfyLF0z2bquxTZ8F2Lo/hne/Pe2Y=";
in
rustPlatform.buildRustPackage {
  inherit pname version cargoHash;

  src = fetchFromGitHub {
    owner = "master-of-zen";
    repo = pname;
    rev = version;
    inherit sha256;
  };

  nativeBuildInputs = [
    pkg-config
    nasm
    makeWrapper
    rustPlatform.bindgenHook
  ];

  nativeCheckInputs = [
    libaom
    rav1e
  ];

  buildInputs = [
    ffmpeg
    x264
    vapoursynth
    python3Packages.vapoursynth
  ];

  postInstall = ''
    wrapProgram $out/bin/av1an \
      --prefix PYTHONPATH : ${python3.pkgs.makePythonPath [ python3Packages.vapoursynth ]}
  '';

  meta = with lib; {
    description = "Cross-platform command-line AV1 / VP9 / HEVC / H264 encoding framework with per scene quality encoding";
    homepage = "https://github.com/master-of-zen/av1an";
    license = licenses.gpl3;
    maintainers = [];
  };
}
