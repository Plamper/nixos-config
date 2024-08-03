{ pkgs, ... }:
{
  config = {
    fonts.packages = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "FiraMono"
          "CascadiaCode"
          "CascadiaMono"
          "Monaspace"
          "NerdFontsSymbolsOnly"
          "GeistMono"
          "FantasqueSansMono"
        ];
      })
      fira
      julia-mono
      mono
      corefonts
      vistafonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts
      noto-fonts-extra
      babelstone-han
      source-han-sans
      cantarell-fonts
      inter
      lmodern
      twitter-color-emoji
    ];
    fonts.fontconfig.defaultFonts.sansSerif = [
      "Inter"
      "Noto Sans"
      "Noto Sans CJK SC"
      "Noto Sans CJK TC"
      "DejaVu Sans"
    ];
    fonts.fontconfig.defaultFonts.serif = [
      "Noto Serif"
      "Noto Serif CJK SC"
      "Noto Serif CJK TC"
      "BabelStone Han"
    ];
    fonts.fontconfig.defaultFonts.emoji = [ 
      "Twitter Color Emoji"
    ];
  };
}
