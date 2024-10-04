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
    # ./mpv.nix
    ./shells.nix
    ./helix.nix
    # ./wezterm.nix
    ./lsp.nix
    ./latex.nix
    ./direnv.nix
    ./browsers.nix
    ./rust.nix
    ./mangohud.nix
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
      # inputs.nixd.overlays.default
      # inputs.emacs-overlay.overlays.default

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
    plattenalbum
    celluloid
    unstable.tutanota-desktop
    thunderbird-128
    anki
    element-desktop
    pika-backup
    gimp
    inkscape
    # unstable.onlyoffice-bin
    signal-desktop
    eyedropper
    nvtopPackages.amd
    unstable.tidal-hifi
    # vesktop
    unstable.mission-center
    # (pkgs.makeAutostartItem { name = "vesktop"; package = pkgs.unstable.vesktop; })
    unstable.rnote
    trayscale
    ffmpeg-full
    handbrake
    mkvtoolnix
    subtitleedit
    helvum
    jellyfin-media-player
    mediainfo
    audacity
    rclone
    lm_sensors
    jamesdsp
    xournalpp
    unstable.drawio

    
    seafile-client
    nextcloud-client


    gnome.adwaita-icon-theme # some apps look buggy without it
    bibata-cursors
    libreoffice

    # dev stuff
    just
    cachix
    unstable.gitui

    nodejs
    # Man Pages
    man-pages
    man-pages-posix
  ];

  # Environment
  home.sessionVariables = {
    # QT_STYLE_OVERRIDE = "adwaita-dark";
    # QT_WAYLAND_DECORATION = "adwaita";
    NIXOS_OZONE_WL = "1";
    BROWSER = "firefox";
    # Vscode
    # GTK_USE_PORTAL = "1";
    #TERMINAL = "blackbox";
  };

  # Code editor Section
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vaapi
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vkcapture
      obs-composite-blur
    ];
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # # Enable Syncthing
  # services.syncthing = {
  #   enable = true;
  # };

  # fonts.fontconfig.enable = true;
  # home.file.".local/share/fonts/FiraCodeNerdFont-Retina_freeze.ttf" = {
  #   source = ./fonts/FiraCodeNerdFont-Retina_freeze.ttf;
  # };

  # To set Blackbox as the default terminal we need to change a dconf setting
  # dconf.settings."com/github/stunkeymonkey/nautilus-open-any-terminal" = {
  #   flatpak = "off";
  #   keybindings = "<Ctrl><Alt>t";
  #   new-tab = false;
  #   terminal = "blackbox";
  # };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # home.sessionPath = [ "$HOME/.local/bin" ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
