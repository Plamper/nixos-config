{ pkgs, lib, config, ... }:
{
  config = {
    i18n.inputMethod = {
      enable = true;
      type = "ibus";
      ibus.engines = with pkgs.ibus-engines; [
        libpinyin
      ];
    };
  };
}
