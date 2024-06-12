# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, pkgs, ... }: {
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
    ../common/optional/virt-manager.nix
    ../common/optional/amd-graphics.nix
    ../common/optional/disc-drive.nix
    ../common/optional/ledger.nix
  ];

  # FIXME: Add the rest of your current configuration
  
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  time.timeZone = "Europe/Berlin";
  
  environment.systemPackages = with pkgs; [
     	neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     	wget
     	curl
     	git
     	sbctl
     	piper
	gnome.nautilus-python # Needed for nautilus extensions
	# nautilus-open-any-terminal
  ];
  
  # TODO: Set your hostname
  networking.hostName = "pc";


  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  # boot.plymouth.enable = true;

  
  fileSystems."/home/felix/Music" = {
    device = "//192.168.1.196/music";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";

      in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
    # or if you have specified `uid` and `gid` explicitly through NixOS configuration,
    # you can refer to them rather than hard-coding the values:
    # in ["${automount_opts},credentials=/etc/nixos/smb-secrets,${config.users.users.<username>.uid},gid=${config.users.groups.<group>.gid}"];
  };


  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
