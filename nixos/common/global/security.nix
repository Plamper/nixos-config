{

  # security.apparmor.enable = true;
  networking.firewall.enable = true;
  networking.nftables.enable = true;
  networking.firewall.interfaces.virbr0.allowedTCPPorts = [ 53 ];
  networking.firewall.interfaces.virbr0.allowedUDPPorts = [ 53 67 ];
}
