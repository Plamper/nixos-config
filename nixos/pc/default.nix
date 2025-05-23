# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, pkgs, ... }:
{
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ../common/global
    ../common/optional/gaming.nix
    ../common/optional/lanzaboote.nix
    ../common/users/felix.nix
    # ../common/optional/virt-manager.nix
    ../common/optional/amd-graphics.nix
    ../common/optional/disc-drive.nix
    ../common/optional/ledger.nix
    ../common/optional/matlab.nix
    ../common/optional/gnome.nix
    ../common/optional/ibus.nix
  ];

  # FIXME: Add the rest of your current configuration

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  boot.kernelParams = [ "amd_pstate=active" ];

  # TODO: Set your hostname
  networking.hostName = "pc";

  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.plymouth.enable = true;

  fileSystems."/home/felix/Music" = {
    device = "//192.168.1.196/Music";
    fsType = "cifs";
    options =
      let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";

      in
      [ "${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=1000" ];
    # or if you have specified `uid` and `gid` explicitly through NixOS configuration,
    # you can refer to them rather than hard-coding the values:
    # in ["${automount_opts},credentials=/etc/nixos/smb-secrets,${config.users.users.<username>.uid},gid=${config.users.groups.<group>.gid}"];
  };

  # last cheched with https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-main/os/x86_64/steamos-customizations-jupiter-20240219.1-2-any.pkg.tar.zst
  boot.kernel.sysctl = {
    # 20-shed.conf
    "kernel.sched_cfs_bandwidth_slice_us" = 3000;
    # 20-net-timeout.conf
    # This is required due to some games being unable to reuse their TCP ports
    # if they're killed and restarted quickly - the default timeout is too large.
    "net.ipv4.tcp_fin_timeout" = 5;
    # 30-vm.conf
    # USE MAX_INT - MAPCOUNT_ELF_CORE_MARGIN.
    # see comment in include/linux/mm.h in the kernel tree.
    "vm.max_map_count" = 2147483642;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
