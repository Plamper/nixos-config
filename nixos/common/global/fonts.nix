{ pkgs, config, ...}:
{
  config = {
    fonts.fonts = with pkgs; [
      nerdfonts
      fira-code
      fira
      emacs-all-the-icons-fonts
      mono
      corefonts
      vistafonts
    ];
  };
}
