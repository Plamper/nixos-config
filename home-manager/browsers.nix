{ pkgs, ... }:
{

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [
      "--enable-features=TouchpadOverscrollHistoryNavigation"
    ];
  };

  # Add Firefox GNOME theme directory
  # home.file."firefox-gnome-theme" = {
  #   target = ".mozilla/firefox/8atw9cvi.default/chrome/firefox-gnome-theme";
  #   source = pkgs.fetchFromGitHub {
  #     owner = "rafaelmardojai";
  #     repo = "firefox-gnome-theme";
  #     rev = "v132";
  #     sha256 = "sha256-lf9MQs8+NUvQd8b5t+7c4kLqUQixGO9WwWcLa1XYuiQ=";
  #   };
  # };

  programs.firefox = {
    enable = true;
    profiles.default = {
      name = "default";
      path = "8atw9cvi.default";
      settings = {
        #"extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

        # For Firefox GNOME theme:
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.tabs.drawInTitlebar" = true;
        "svg.context-properties.content.enabled" = true;
        # "gnomeTheme.extensions.tabCenterReborn" = true;
        "gnomeTheme.hideWebrtcIndicator" = true;
        "gnomeTheme.hideSingleTab" = true;
        "extensions.pocket.enabled" = false;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "layers.acceleration.force-enabled" = true;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "widget.use-xdg-desktop-portal.location" = 1;
        "widget.use-xdg-desktop-portal.mime-handler" = 1;
        "widget.use-xdg-desktop-portal.open-uri" = 1;
        "widget.use-xdg-desktop-portal.settings" = 1;
      };
      # userChrome = ''
      #   @import "firefox-gnome-theme/userChrome.css";
      #   @import "firefox-gnome-theme/theme/colors/dark.css"; 
      # '';
    };
    nativeMessagingHosts = with pkgs; [
      zotero
      bitwarden-desktop
    ];
  };

  # # Add Firefox GNOME theme directory
  # home.file."thunderbird-gnome-theme" = {
  #   target = ".thunderbird/8atw9cvi.default/chrome/thunderbird-gnome-theme";
  #   source = pkgs.fetchFromGitHub {
  #     owner = "rafaelmardojai";
  #     repo = "thunderbird-gnome-theme";
  #     rev = "main";
  #     sha256 = "sha256-nQBz2PW3YF3+RTflPzDoAcs6vH1PTozESIYUGAwvSdA=";
  #   };
  # };

  # programs.thunderbird = {
  #   enable = true;
  #   profiles.default = {
  #     #name = "default";
  #     isDefault = true;
  #     # path = "eoncii00.default";
  #     settings = {
  #       #"extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

  #       # For Thunderbird GNOME theme:
  #       "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  #       "svg.context-properties.content.enabled" = true;
  #       "media.ffmpeg.vaapi.enabled" = true;
  #       "media.hardware-video-decoding.force-enabled" = true;
  #       "layers.acceleration.force-enabled" = true;
  #       "widget.use-xdg-desktop-portal.file-picker" = 1;
  #       "widget.use-xdg-desktop-portal.location" = 1;
  #       "widget.use-xdg-desktop-portal.mime-handler" = 1;
  #       "widget.use-xdg-desktop-portal.open-uri" = 1;
  #       "widget.use-xdg-desktop-portal.settings" = 1;
  #     };
  #     userChrome = ''
  #       @import "thunderbird-gnome-theme/userChrome.css";
  #       @import "thunderbird-gnome-theme/theme/colors/dark.css"; 
  #     '';
  #   };
  # };

}
