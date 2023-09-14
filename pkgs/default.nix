# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs ? (import ../nixpkgs.nix) { }, nixpak }: {
  # example = pkgs.callPackage ./example { };
  brave-nixpak = let
    mkNixPak = nixpak.lib.nixpak {
      inherit (pkgs) lib;
      inherit pkgs;
    };
  in (import ./nixpaks/brave-nixpak.nix {
    inherit mkNixPak;
    inherit (pkgs) brave;
  }).config.env;
}
