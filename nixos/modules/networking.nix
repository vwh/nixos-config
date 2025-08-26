# Networking configuration (NetworkManager).
# This module configures the system networking using NetworkManager,
# which provides automatic network detection, configuration, and management.

{
  # Enable NetworkManager for network configuration
  # NetworkManager automatically detects and configures network interfaces,
  # supports WiFi, Ethernet, VPN, and provides a user-friendly interface
  networking.networkmanager.enable = true;
}
