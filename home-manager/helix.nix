{ pkgs, ... }:
{
  config = {
    programs.helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        # theme = "adwaita-dark";
        theme = "tokyonight_moon";
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
          end-of-line-diagnostics = "hint";
          inline-diagnostics.cursor-line = "warning";
        };
      };
      languages = {
        language = [
          {
            name = "nix";
            # language-servers = [ "nixd" "nil" ];
            formatter = { command = "nixpkgs-fmt"; };
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
            formatter = { command = "mdformat"; args = [ "-" ]; };
          }
        ];
        # language-server = {
        #   nixd = {
        #     command = "nixd";
        #   };
        # };
      };
      package = pkgs.unstable.helix;
    };
    home.packages = with pkgs; [
      wl-clipboard
      wl-clipboard-x11
    ];


  };
}
