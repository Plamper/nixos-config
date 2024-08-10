{ pkgs, ... }:
{
  config = {
    # Random lsps where I didn't bother to create
    # a seperate language specific file
    home.packages = with pkgs;[
      marksman
      # nil
      unstable.nixd
      nixpkgs-fmt
    ];
  };
}
