{ pkgs, ... }:
{
  config = {
    home.packages = with pkgs; [
      ltex-ls
      texlab
      texlive.combined.scheme-full
      pympress
      pandoc
    ];
  };
}
