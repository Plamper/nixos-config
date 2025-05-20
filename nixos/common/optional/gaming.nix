{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = {
    programs.steam.enable = true;
    # programs.steam.gamescopeSession = {
    #   enable = true;
    #   args = [
    #     "--hdr-enabled"
    #     "--hdr-itm-enable"
    #     "--xwayland-count 2"
    #   ];
    # };
    programs.steam.extraPackages = with pkgs; [
      xorg.libXcursor
      xorg.libXi
      xorg.libXinerama
      xorg.libXScrnSaver
      xorg.xrandr
      libpng
      libpulseaudio
      libvorbis
      stdenv.cc.cc.lib
      libkrb5
      keyutils
      libva
      noto-fonts-cjk-sans
      noto-fonts
      vulkan-hdr-layer-kwin6
    ];
    # Steam Game transfers
    networking.firewall.allowedTCPPorts = [ 27040 ];
    networking.firewall.allowedUDPPortRanges = [
      {
        from = 27031;
        to = 27036;
      }
    ];

    # services.hardware.openrgb = {
    #   enable = true;
    #   package = pkgs.openrgb-with-all-plugins;
    #   motherboard = "amd";
    # };
    # hardware.i2c.enable = true;

    programs.gamescope = {
      enable = true;
      package = pkgs.gamescope;
      capSysNice = true;
    };

    hardware.keyboard.qmk.enable = true;
    services.udev.packages = [
      pkgs.via
      pkgs.openrgb-with-all-plugins
    ];

    services.ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-rules-cachyos;
    };

    # programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      mangohud
      prismlauncher
      protontricks
      steamtinkerlaunch
      heroic
      # (lutris.override {
      #   extraPkgs = pkgs: [
      #     # List package dependencies here
      #     wine
      #     wine-staging
      #   ];
      # })
      r2modman
      ludusavi
      via
      openrgb-with-all-plugins
      protonplus
      vulkan-hdr-layer
      scx.full
      gamescope-wsi
    ];
  };
}
