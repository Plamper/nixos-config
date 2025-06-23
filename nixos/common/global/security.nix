{

  # security.apparmor.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      # Packet
      9300
    ];
    allowedUDPPorts = [
      # Packet
      9300
      # Ausweisapp
      24727
    ];
    interfaces.virbr0.allowedTCPPorts = [ 53 ];
    interfaces.virbr0.allowedUDPPorts = [
      53
      67
    ];
  };
}
