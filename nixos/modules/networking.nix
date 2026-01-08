# Networking configuration (NetworkManager).
# Enhanced with DNS integration and WiFi privacy settings.

{ lib, ... }:

{
  networking.networkmanager = {
    enable = true;

    # Let DNSCrypt-Proxy handle DNS resolution
    dns = "none";

    # WiFi privacy: Randomize MAC address per network
    wifi = {
      macAddress = "random"; # Random MAC for each new WiFi network
      scanRandMacAddress = true; # Random MAC during WiFi scans
    };

    # Ethernet: Use stable MAC (needed for DHCP reservations)
    ethernet = {
      macAddress = "permanent";
    };
  };

  # IMPORTANT: Disable resolved to let DNSCrypt-Proxy handle all DNS
  # mkForce is needed because Mullvad VPN module tries to enable it
  # DNS is handled by: DNSCrypt -> Mullvad (if connected) -> Cloudflare
  services.resolved.enable = lib.mkForce false;
}
