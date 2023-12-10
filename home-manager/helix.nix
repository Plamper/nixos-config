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
        editor = {
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          statusline = {
            mode = {
              normal = "NORMAL";
              insert = "INSERT";
              select = "SELECT";
            };
          };
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
    home.packages = with pkgs; [
      wl-clipboard
      wl-clipboard-x11
    ];
  };
}
