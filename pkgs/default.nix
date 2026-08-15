# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{
  pkgs ? (import ../nixpkgs.nix) { },
}:
{
  pywhispercpp = pkgs.callPackage ./pywhispercpp { };
  moonshineVoice = pkgs.callPackage ./moonshine-voice { };
  ibus-speech-to-text = pkgs.callPackage ./ibus-speech-to-text { };
}
