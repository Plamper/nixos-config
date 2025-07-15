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
      noto-fonts-color-emoji
      babelstone-han
      source-han-sans
      source-sans
      source-serif
      cabin
      crimson-pro
      garamond-libre
      alegreya
      alegreya-sans
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
      _0xproto
    ]));
    fonts.fontconfig.defaultFonts.sansSerif = [
      "Adwaita Sans"
      "Noto Color Emoji"
      "Noto Sans"
      "Noto Sans CJK SC"
      "Noto Sans CJK TC"
      "DejaVu Sans"
    ];
    fonts.fontconfig.defaultFonts.serif = [
      "Noto Serif"
      "Noto Color Emoji"
      "Noto Serif CJK SC"
      "Noto Serif CJK TC"
    ];
    fonts.fontconfig.defaultFonts.emoji = [
      "Noto Color Emoji"
    ];
    fonts.fontconfig.subpixel.rgba = "rgb";
  };
}
