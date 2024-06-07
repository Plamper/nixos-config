{ pkgs, lib, config, ... }:
{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      plasma6Support = true;
      addons = with pkgs; [
        fcitx5-chinese-addons        
        fcitx5-table-extra
        fcitx5-chewing
      ];
    };
  };
}
