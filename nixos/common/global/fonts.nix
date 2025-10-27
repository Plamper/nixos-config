{ pkgs, ... }:
{
  config = {
    fonts.packages = (
      (with pkgs; [
        fira
        fira-code
        fira-math
        julia-mono
        mono
        corefonts
        vistafonts
        vista-fonts-cht
        vista-fonts-chs
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
        gyre-fonts
        cantarell-fonts
        inter
        lmodern
        stix-two
        xits-math
        twitter-color-emoji
        ibm-plex
        libertine
        libertine-g
      ])
      ++ (with pkgs.nerd-fonts; [
        fira-code
        fira-mono
        caskaydia-cove
        caskaydia-mono
        monaspace
        symbols-only
        geist-mono
        _0xproto
      ])
    );
    fonts.fontconfig.defaultFonts.sansSerif = [
      "Adwaita Sans"
      "Noto Sans"
      "Noto Sans CJK SC"
      "Noto Sans CJK TC"
    ];
    fonts.fontconfig.defaultFonts.serif = [
      "Noto Serif"
      "Noto Serif CJK SC"
      "Noto Serif CJK TC"
    ];
    fonts.fontconfig.defaultFonts.monospace = [
      "Adwaita Mono"
      "Noto Sans Mono"
      "Noto Sans Mono CJK SC"
      "Noto Sans Mono CJK TC"
    ];
    fonts.fontconfig.defaultFonts.emoji = [
      "Noto Color Emoji"
    ];
    fonts.fontconfig.subpixel.rgba = "rgb";
  };
}
