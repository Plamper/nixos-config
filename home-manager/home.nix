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
    ./shells.nix
    ./helix.nix
    ./wezterm.nix
    ./lsp.nix
    ./gnome-extensions.nix
    ./python.nix
    ./c.nix
    ./latex.nix
    ./direnv.nix
    ./browsers.nix
    #./gtk.nix
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

      # inputs.prismlauncher.overlays.default # just using nixpkgs for now
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
    imagemagick
    # For editing pdfs with imagemagick
    celluloid
    mpdevil
    amberol
    unstable.blackbox-terminal
    gnome.dconf-editor
    gnome.gnome-tweaks
    gnome.file-roller
    unstable.tutanota-desktop
    unstable.thunderbird
    unstable.anki
    element-desktop
    pika-backup
    adw-gtk3
    protonvpn-gui
    gimp
    inkscape
    onlyoffice-bin_7_5
    signal-desktop
    vlc
    eyedropper
    nvtop-amd
    easyeffects
    tidal-hifi
    discord

    libreoffice
    hunspell
    hunspellDicts.en_US
    hunspellDicts.de_DE

    # dev stuff
    just
    cachix
    unstable.gitui

    unstable.jetbrains.rider
    dotnet-sdk_6
    gnome-builder

    nodejs
    # Man Pages
    man-pages
    man-pages-posix
  ];

  # Environment
  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "adwaita-dark";
    NIXOS_OZONE_WL = "1";
    BROWSER = "firefox";
    #TERMINAL = "blackbox";
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

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Enable Syncthing
  services.syncthing = {
    enable = true;
  };

  fonts.fontconfig.enable = true;
  home.file.".local/share/fonts/FiraCodeNerdFont-Retina_freeze.ttf" = {
    source = ./fonts/FiraCodeNerdFont-Retina_freeze.ttf;
  };

  # To set Blackbox as the default terminal we need to change a dconf setting
  # dconf.settings."com/github/stunkeymonkey/nautilus-open-any-terminal" = {
  #   flatpak = "off";
  #   keybindings = "<Ctrl><Alt>t";
  #   new-tab = false;
  #   terminal = "blackbox";
  # };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.sessionPath = [ "$HOME/.local/bin" ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
