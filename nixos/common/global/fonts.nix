{ pkgs, config, ... }:
{
  config = {
    fonts.packages = with pkgs; [
      unstable.nerdfonts
      fira-code
      fira
      emacs-all-the-icons-fonts
      mono
      corefonts
      vistafonts
      noto-fonts-cjk-sans
      noto-fonts
      noto-fonts-extra
      babelstone-han
      cantarell-fonts
      unstable.geist-font
      unstable.monaspace
    ];
    fonts.fontconfig.defaultFonts.sansSerif = [
      "Cantarell"
      "DejaVu Sans"
      "Noto Sans"
      "Noto Sans CJK SC"
      "Noto Sans CJK TC"
      "Noto Color Emoji"
      "Noto Emoji"
      "BabelStone Han"
    ];
  };
}
