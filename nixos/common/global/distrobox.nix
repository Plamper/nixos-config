{ pkgs, config, ...}:
{
  config = {
    environment.systemPackages = with pkgs;[
      distrobox
    ];
    virtualisation.docker.enable = true;
    users.extraGroups.docker.members = [ "felix" ];
    virtualisation.docker.storageDriver = "btrfs";
  };
}
