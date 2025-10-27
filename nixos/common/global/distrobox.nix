{ pkgs, config, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      distrobox
      podman-compose
      toolbox
    ];
    virtualisation.podman.enable = true;
    virtualisation.containers.enable = true;
  };
}
