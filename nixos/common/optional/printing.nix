{ pkgs, ... }:
{
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];
  services.printing.startWhenNeeded = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;
}
