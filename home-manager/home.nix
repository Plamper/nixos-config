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
    # steam
    imagemagick
    # For editing pdfs with imagemagick
    ghostscript
    gnome-extension-manager
    celluloid
    mpdevil
    amberol
    unstable.blackbox-terminal # using flatpak version for now
    gnome.dconf-editor
    gnome.gnome-tweaks
    gnome.file-roller
    unstable.tutanota-desktop
    unstable.thunderbird
    nautilus-open-any-terminal
    unstable.anki-bin
    element-desktop
    pika-backup
    adw-gtk3
    protonvpn-gui
    gimp
    lutris
    onlyoffice-bin_7_4
    # grc

    # Gnome Extensions
    gnomeExtensions.pano
    gnomeExtensions.blur-my-shell
    gnomeExtensions.bing-wallpaper-changer
    gnomeExtensions.caffeine
    gnomeExtensions.gsconnect
    gnomeExtensions.appindicator
    gnomeExtensions.rounded-window-corners
    gnomeExtensions.tiling-assistant
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.legacy-gtk3-theme-scheme-auto-switcher

    # dev stuff
    (hiPrio gcc13)
    nil
    nixd
    nixpkgs-fmt
    cmake
    gnumake
    cachix
    ccls
    gdb
    python3
    clang
    
    jetbrains.rider
    dotnet-sdk_6


    # Man Pages
    man-pages
    man-pages-posix
  ];

  # Environment
  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "adwaita-dark";
    NIXOS_OZONE_WL = "1";
    BROWSER = "brave";
    TERMINAL = "blackbox";
  };

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [
      "--enable-features=TouchpadOverscrollHistoryNavigation"
    ];
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
    tray.enable = true;
  };

  # The syncthing tray complains about tray.target
  # so we just pretend its there
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
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

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
