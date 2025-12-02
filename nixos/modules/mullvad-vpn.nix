# Mullvad VPN configuration.
# This module enables Mullvad VPN service with both CLI and GUI support.
# Mullvad uses WireGuard under the hood and provides privacy-focused VPN service.

{ pkgs, ... }:

{
  # Enable systemd-resolved (required for Mullvad VPN to work properly)
  services.resolved.enable = true;

  # Enable Mullvad VPN service
  services.mullvad-vpn = {
    enable = true;
    # Use the GUI package for easy management and desktop integration
    package = pkgs.mullvad-vpn;
  };

  # Add Mullvad VPN to system packages for CLI access
  environment.systemPackages = with pkgs; [
    mullvad-vpn # CLI and GUI for Mullvad VPN
  ];
}
