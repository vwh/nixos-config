# Tor service configuration for privacy and anonymity.

{
  services.tor = {
    enable = true; # Enable Tor daemon
    torsocks.enable = true; # Enable torsocks for transparent Tor routing
    client.enable = true; # Enable Tor client functionality
  };
}
