{
  inputs,
  pkgs,
  config,
  ...
}:
{

  home.packages = with pkgs; [
    google-chrome
  ];

  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    nativeMessagingHosts = with pkgs; [
      zotero
      # bitwarden-desktop
    ];
  };

  # home.nix
  imports = [
    inputs.zen-browser.homeModules.beta
    # or inputs.zen-browser.homeModules.twilight
    # or inputs.zen-browser.homeModules.twilight-official
  ];

  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = with pkgs; [
      zotero
      # bitwarden-desktop
    ];
  };
}
