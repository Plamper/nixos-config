{ pkgs, ... }:
{
  config = {
    programs.helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        theme = "adwaita-dark";
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
          {
            name = "markdown";
            language-servers = [ "marksman" "ltex-ls" ];
            soft-wrap = { enable = true; };
            auto-format = true;
            formatter = { command = "mdformat"; args = [ "--wrap" "80" "-" ]; };
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
