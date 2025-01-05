{ config, pkgs, ... }:
{
  config = {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    users.users."felix".extraGroups = [ "libvirtd" ];

    # virtualisation.virtualbox.host.enable = true;
    # users.extraGroups.vboxusers.members = [ "felix" ];
    # virtualisation.virtualbox.host.enableExtensionPack = true;
  };
}
