{ pkgs, ... }:
{
  # Enable Zsh systemwide, Configuration is done with home manager
  programs.zsh.enable = true;
  programs.fish.enable = true;
  environment.shells = with pkgs; [
    zsh
    fish
  ];
  environment.pathsToLink = [ "/share/zsh" ];
}
