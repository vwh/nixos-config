# Bluetooth configuration.

{ pkgsStable, ... }:

{
  hardware.bluetooth = {
    enable = true; # Enable Bluetooth adapter support
    powerOnBoot = false; # Don't power on Bluetooth automatically at boot
  };

  # Enable Blueman Bluetooth manager service
  services.blueman.enable = true;

  # Install Bluetooth management utilities
  environment.systemPackages = with pkgsStable; [ blueman ];
}
