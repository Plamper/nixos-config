{ pkgs, ... }:
{
  config = {
    fonts.packages = ((with pkgs; [
      fira
      fira-code
      fira-math
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
      stix-two
      xits-math
      twitter-color-emoji
      ibm-plex
      libertine
      libertine-g
    ]) ++ (with pkgs.nerd-fonts; [
      fira-code
      fira-mono
      caskaydia-cove
      caskaydia-mono
      monaspace
      symbols-only
      geist-mono
    ]));
    fonts.fontconfig.defaultFonts.sansSerif = [
      "Inter"
      "Twitter Color Emoji"
      "Noto Sans"
      "Noto Sans CJK SC"
      "Noto Sans CJK TC"
      "DejaVu Sans"
    ];
    fonts.fontconfig.defaultFonts.serif = [
      "Noto Serif"
      "Twitter Color Emoji"
      "Noto Serif CJK SC"
      "Noto Serif CJK TC"
    ];
    fonts.fontconfig.defaultFonts.emoji = [
      "Twitter Color Emoji"
    ];
    fonts.fontconfig.subpixel.rgba = "rgb";
  };
}
