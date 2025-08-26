# Power management and performance configuration for ThinkPad.
# This module configures power management settings optimized for ThinkPad
# laptops, including thermal throttling prevention and power profiles.

{ lib, ... }:

{
  # Enable NixOS power management
  powerManagement.enable = true;

  # Game mode configuration
  # Disabled to prevent automatic CPU governor changes during gaming
  programs.gamemode.enable = false;

  services = {
    # Disable power-profiles-daemon to avoid conflicts with TLP
    power-profiles-daemon.enable = false;

    # Enable ThinkPad throttling prevention daemon
    # Helps prevent thermal throttling on ThinkPad laptops
    throttled.enable = lib.mkDefault true;
  };
}
