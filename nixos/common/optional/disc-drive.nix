{ pkgs, ... }:
{
  config = {
    environment.systemPackages = with pkgs;[
      makemkv
      freac
      libaacs
    ];
  };
}
