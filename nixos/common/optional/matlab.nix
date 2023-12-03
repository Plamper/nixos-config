{ config, pkgs, options, lib, inputs, ... }:
{

  config = {
    nixpkgs.overlays = [
      inputs.nix-matlab.overlay
    ];
    environment.systemPackages = with pkgs; [
      matlab
    ];
  };
}
