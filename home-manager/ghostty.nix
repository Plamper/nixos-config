{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "tokyonight_moon";
      font-size = 14;
      font-family = "CaskaydiaCove Nerd Font";
      window-theme = "ghostty";
      gtk-custom-css= "custom.css";
    };
  };
  home.file.".config/ghostty/custom.css".text =
    # css
    ''
      :root {

        /* New Tab Button */
        --accent-bg-color: #7496E1;

        /* Headerbar */
        --headerbar-bg-color: #272B47;
        --headerbar-backdrop-color: #2B2F4B;

        /* Tab overview */
        --window-bg-color: #272B47;

        /* Hamburger menu */
        --popover-bg-color: #272B47;
        
        /* Close Warning */
        --dialog-bg-color: #272B47; 
      }
    '';
}
