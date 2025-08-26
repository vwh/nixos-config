# Tor service configuration for privacy and anonymity.

{ lib, ... }:

{
  services.tor = {
    enable = lib.mkDefault true; # Enable Tor daemon (can be overridden)
    torsocks.enable = true; # Enable torsocks for transparent Tor routing
    client.enable = true; # Enable Tor client functionality
  };
}
