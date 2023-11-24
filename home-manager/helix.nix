{ pkgs, ...}:
{
  config = {
    programs.helix = {
      enable = true;
      settings = {
        theme = "adwaita-dark";
      };
      package = pkgs.unstable.helix;
    };
  };
}
