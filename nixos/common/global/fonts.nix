{ pkgs, config, ...}:
{
  config = {
    fonts.packages = with pkgs; [
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
