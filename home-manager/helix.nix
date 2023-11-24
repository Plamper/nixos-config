{ pkgs, ... }:
{
  config = {
    programs.helix = {
      enable = true;
      settings = {
        theme = "adwaita-dark";
        keys.normal = {
          esc = [ "collapse_selection" "keep_primary_selection" ];
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
