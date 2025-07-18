{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = {
    i18n.inputMethod = {
      enable = true;
      type = "ibus";
      ibus.engines = with pkgs.ibus-engines; [
        libpinyin
      ];
    };
    environment.variables.GTK_IM_MODULE = lib.mkForce "";
  };
}
