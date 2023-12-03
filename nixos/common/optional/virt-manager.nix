{ config, pkgs, ... }:
{
  config = {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    users.users."felix".extraGroups = [ "libvirtd" ];
  };
}
