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
    ./audio.nix
    ./emacs
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
      inputs.nixd.overlays.default
      inputs.emacs-overlay.overlays.default

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
    unstable.blackbox-terminal # using flatpak version for now
    gnome.dconf-editor
    gnome.gnome-tweaks
    gnome.file-roller
    tutanota-desktop
    unstable.thunderbird
    prismlauncher
    nautilus-open-any-terminal
    unstable.anki-bin
    # grc

    # dev stuff
    gcc13
    nil
    nixd
    nixpkgs-fmt
    cmake
    gnumake
    cachix

    #Fonts
    nerdfonts
    fira-code
    emacs-all-the-icons-fonts
  ];

  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "adwaita-dark";
    NIXOS_OZONE_WL = "1";
  };


  # Code editor Section
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      piousdeer.adwaita-theme
      # llvm-vs-code-extensions.vscode-clangd
      ms-vscode.cpptools
      jnoortheen.nix-ide
      ms-vscode.cmake-tools
    ];
  };

  programs.bash.enable = true;

  # programs.zsh = {
  #   enable = true;
  #   enableAutosuggestions = true;
  #   enableCompletion = true;
  #   # doesn't seem to work
  #   enableVteIntegration = true;
  #   autocd = true;
  #   shellAliases = {
  #     ll = "ls -l";
  #     update-system = "cd /home/felix/Nix-Configuration && sudo nixos-rebuild switch --flake .#pc";
  #     update-home = "cd /home/felix/Nix-Configuration && home-manager switch --flake .#felix@pc";
  #     update-flake = "cd /home/felix/Nix-Configuration && nix flake update";
  #   };
  #   history = {
  #     size = 10000;
  #     path = "${config.xdg.dataHome}/zsh/history";
  #   };
  #   initExtra = ''bindkey "''${key[Up]}" up-line-or-search'';
  # };
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = [
      { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
      { name = "z"; src = pkgs.fishPlugins.z.src; }
    ];
    shellAbbrs = {
      update-system = "sudo nixos-rebuild switch --flake /home/felix/Nix-Configuration#pc";
      update-home = "home-manager switch --flake /home/felix/Nix-Configuration#felix@pc";
      update-flake = "nix flake update /home/felix/Nix-Configuration";
    };
  };

  fonts.fontconfig.enable = true;
  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      add_newline = false;

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      c.symbol = " ";
      git_branch.symbol = " ";
      package.symbol = "󰏗 ";
      hostname.ssh_symbol = " ";
      rust.symbol = " ";
      directory = {
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
          "Nix-Configuration" = " ";
        };
      };
      # package.disabled = true;
    };
  };


  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
