{
  # Disable the traditional firewall in favor of firewalld
  networking.firewall.enable = false;
  networking.nftables.enable = true;

  services.firewalld = {
    enable = true;

    zones = {
      # Home zone for trusted networks (e.g., home WiFi)
      # Very permissive - allows all traffic by default
      home = {
        description = "Home network";
        forward = true;
        target = "ACCEPT";
      };

      # Work zone for semi-trusted networks (e.g., office WiFi)
      # Moderate restrictions - allows specific services
      work = {
        description = "Work network";
        forward = true;
        target = "ACCEPT";
        services = [ "ssh" "dhcpv6-client" ];
      };

      # Public zone for untrusted networks (e.g., public WiFi, mobile networks)
      # Most restrictive - rejects traffic by default
      public = {
        description = "Public networks";
        forward = true;
        target = "DROP";
        services = [ "dhcp" "dns" ];
      };
    };
  };
}
