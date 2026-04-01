{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = {
    programs.steam.enable = true;
    programs.steam.gamescopeSession = {
      enable = true;
      args = [
        "--hdr-enabled"
        "--hdr-itm-enable"
        "--xwayland-count 2"
      ];
    };
    # programs.steam.extraPackages = with pkgs; [
    #   xorg.libXcursor
    #   xorg.libXi
    #   xorg.libXinerama
    #   xorg.libXScrnSaver
    #   xorg.xrandr
    #   libpng
    #   libpulseaudio
    #   libvorbis
    #   stdenv.cc.cc.lib
    #   libkrb5
    #   keyutils
    #   libva
    #   noto-fonts-cjk-sans
    #   noto-fonts
    # ];
    programs.steam.fontPackages = with pkgs; [
      noto-fonts-cjk-sans
      noto-fonts
    ];
    # Steam Game transfers
    networking.firewall.allowedTCPPorts = [ 27040 ];
    networking.firewall.allowedUDPPortRanges = [
      {
        from = 27031;
        to = 27036;
      }
    ];

    hardware.xpadneo.enable = true;
    # 8bitdo controller
    boot.extraModprobeConfig = ''
      options hid_xpadneo quirks=E4:17:D8:xx:xx:xx+32
    '';

    # services.hardware.openrgb = {
    #   enable = true;
    #   package = pkgs.openrgb-with-all-plugins;
    #   motherboard = "amd";
    # };
    # hardware.i2c.enable = true;

    programs.gamescope = {
      enable = true;
      package = pkgs.gamescope;
      # capSysNice = true;
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
      extraRules = [
        {
          "name" = "gamescope";
          "nice" = -20;
        }
      ];
    };

    # programs.gamemode.enable = true;
    programs.gpu-screen-recorder.enable = true;

    environment.systemPackages = with pkgs; [
      mangohud
      prismlauncher
      protontricks
      steamtinkerlaunch
      heroic
      libdecor
      gpu-screen-recorder-gtk
      r2modman
      ludusavi
      via
      openrgb-with-all-plugins
      protonplus
      # scx.rustscheds
      gamescope-wsi
    ];
  };
}
