{ pkgs, ... }:
{
  config = {
    programs.helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        theme = "tokyonight_storm";
        keys.normal = {
          esc = [ "collapse_selection" "keep_primary_selection" ];
        };
        editor.cursor-shape = {
          insert = "bar";
        };
      };
      languages = {
        language = [
          {
            name = "nix";
            language-servers = [ "nixd" "nil" ];
          }
          {
            name = "latex";
            language-servers = [ "texlab" "ltex-ls" ];
          }
        ];
        language-server = {
          nixd = {
            command = "nixd";
          };
        };
      };
      package = pkgs.unstable.helix;
    };
  };
}
