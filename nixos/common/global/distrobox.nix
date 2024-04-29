{ pkgs, config, ... }:
{
  config = {
    environment.systemPackages = with pkgs;[
      distrobox
    ];
    virtualisation.podman.enable = true;
    virtualisation.containers.enable = true;
  };
}
