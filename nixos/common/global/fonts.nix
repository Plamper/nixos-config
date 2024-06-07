{ pkgs, config, ... }:
{
  config = {
    fonts.packages = with pkgs; [
      unstable.nerdfonts
      fira-code
      fira
      julia-mono
      emacs-all-the-icons-fonts
      mono
      corefonts
      vistafonts
      noto-fonts-cjk-sans
      noto-fonts
      noto-fonts-extra
      babelstone-han
      source-han-sans
      cantarell-fonts
      unstable.geist-font
      unstable.monaspace
    ];
    fonts.fontconfig.defaultFonts.sansSerif = [
      "Noto Sans"
      "Noto Sans CJK SC"
      "Noto Sans CJK TC"
      "Noto Color Emoji"
      "Noto Emoji"
      "Cantarell"
      "DejaVu Sans"
    ];
    fonts.fontconfig.defaultFonts.serif = [
      "Noto Serif"
      "Noto Serif CJK SC"
      "Noto Serif CJK TC"
      "Noto Color Emoji"
      "Noto Emoji"
      "BabelStone Han"
    ];
  };
}
