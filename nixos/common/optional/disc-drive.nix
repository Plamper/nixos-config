{ pkgs, ... }:
{
  config = {
    environment.systemPackages = with pkgs;[
      unstable.makemkv
      # freac
      libaacs
    ];
  };
}
