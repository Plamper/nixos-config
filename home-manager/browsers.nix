{ pkgs, ... }:
{

  programs.chromium = {
    enable = true;
    package = pkgs.unstable.brave;
    commandLineArgs = [
      "--enable-features=TouchpadOverscrollHistoryNavigation"
      "--gtk-version=4"
    ];
  };

  # Add Firefox GNOME theme directory
  home.file."firefox-gnome-theme" = {
    target = ".mozilla/firefox/8atw9cvi.default/chrome/firefox-gnome-theme";
    source = pkgs.fetchFromGitHub {
      owner = "rafaelmardojai";
      repo = "firefox-gnome-theme";
      rev = "v120";
      sha256 = "sha256-CBw2JMrQO5ymFVyR/Qtcn5iTp+Hp0sQe7v0DviH9zRY=";
    };
  };

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
      };
      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";
        @import "firefox-gnome-theme/theme/colors/dark.css"; 
      '';
    };
  };

}
