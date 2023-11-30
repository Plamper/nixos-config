{ pkgs, ... }:
{
  config = {
    programs.helix = {
      enable = true;
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
            formatter = { command = "nixpkgs-fmt"; };
          }
          {
            name = "latex";
            language-servers = [ "texlab" "ltex-ls" ];
          }
        ];
      };
      package = pkgs.unstable.helix;
    };
  };
}
