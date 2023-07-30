# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
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

      inputs.prismlauncher.overlays.default

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
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  # TODO: Set your username
  home = {
    username = "felix";
    homeDirectory = "/home/felix";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    # steam
    brave
    gnome-extension-manager
    mangohud
    gamescope
    celluloid
    mpdevil
    amberol
    nautilus-open-any-terminal
    unstable.blackbox-terminal
    gnome.dconf-editor
    gnome.gnome-tweaks
    gnome.file-roller
    tutanota-desktop
    unstable.thunderbird
    prismlauncher

    # dev stuff
    gcc13
    nil
    nixpkgs-fmt

    #Fonts
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    fira-code
  ];

  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "adwaita-dark";
    NIXOS_OZONE_WL = "1";
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      piousdeer.adwaita-theme
      llvm-vs-code-extensions.vscode-clangd
      ms-vscode.cpptools
      jnoortheen.nix-ide
    ];
  };

  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
    extraConfig = '' 
        audio_output {  
          type	"pipewire" #
          name  "Pipewire"  #
          dsd         "yes"  #
        }
     '';
  };
  services.mpd-mpris.enable = true;

  programs.bash.enable = true; 

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autocd = true;
    shellAliases = {
      ll = "ls -l";
      update-system = "cd /home/felix/Nix-Configuration && sudo nixos-rebuild switch --flake .#pc";
      update-home = "cd /home/felix/Nix-Configuration && home-manager switch --flake .#felix@pc";
      update-flake = "cd /home/felix/Nix-Configuration && nix flake update";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    initExtra = ''bindkey "''${key[Up]}" up-line-or-search'';
    plugins = [
      {
      name = "spaceship";
      file = "spaceship.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "spaceship-prompt";
        repo = "spaceship-prompt";
        rev = "v4.14.0";
        sha256 = "sha256-aoifMAjJvv1WAlINNkMwCCop6znxyivoD3vQDo/ZbfQ=";
      };
    }
    ];
  };
  fonts.fontconfig.enable = true;

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
