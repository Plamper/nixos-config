{ pkgs, config, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      distrobox
      podman-compose
    ];
    virtualisation.podman.enable = true;
    virtualisation.containers.enable = true;
  };
}
