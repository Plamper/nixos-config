# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example
    
    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd
    
    # import lanzaboote
    inputs.lanzaboote.nixosModules.lanzaboote

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  # FIXME: Add the rest of your current configuration
  
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  security.apparmor.enable = true;
  
  time.timeZone = "Europe/Berlin";
  
  environment.systemPackages = with pkgs; [
     	neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     	wget
     	curl
     	git
     	sbctl
     	piper
  ];
  
  # Pipewire Setup
  sound.enable = false;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };
  environment.etc."pipewire/pipewire.conf.d/10-default.clock.allowed-rates.conf".text = ''
    context.properties = {
      default.clock.rate          = 44100
      default.clock.allowed-rates = [ 44100 48000 88200 96000 176400 192000 352800 384000 705600 768000 ]
    }
  '';
  
  # steam doesn't work with home manager it seems
  programs.steam.enable = true;
  programs.gamemode.enable = true;

  # Enable Flatpak and Ratbagd
  services.flatpak.enable = true;
  services.ratbagd.enable = true;
  
  # TODO: Set your hostname
  networking.hostName = "pc";

  # Change Bootloader to Lanzaboote for Secureboot
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.timeout = 0;
  
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
  
  boot.initrd.systemd.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_lqx;
  boot.kernelParams = [ 
    "amd_pstate=active"
    # "quiet"
  ];
  # boot.plymouth.enable = true;

  # Enable Zsh systemwide Configuration is done with home manager
  programs.zsh.enable = true;
  programs.fish.enable = true;
  environment.shells = with pkgs; [ zsh fish ];
  environment.pathsToLink = [ "/share/zsh" ];

  # Install android udev rules
  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  # For Cachix
  nix.settings.trusted-users = [ "root" "felix" ];

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    # FIXME: Replace with your username
    felix = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "123";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ "wheel" ];
      description = "Felix Plamper";
      shell = pkgs.fish;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
