# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs ? (import ../nixpkgs.nix) { } }: {
  # example = pkgs.callPackage ./example { };
  # av1an = pkgs.callPackage ./av1an.nix { vapoursynth = pkgs.vapoursynth; };
  # vapoursynth-lsmash = pkgs.callPackage ./vapoursynth-lsmash.nix {};
  # svt-av1-psy = pkgs.callPackage ./svt-av1-psy.nix {};
  # real-cugan = pkgs.callPackage ./real-cugan {};
  # vapoursynth-realesrgan-nccnn-vulkan = pkgs.callPackage ./vapoursynth-realesrgan-nccnn-vulkan { stdenv = pkgs.gcc13Stdenv; };
}
