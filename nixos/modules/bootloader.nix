# Bootloader configuration (systemd-boot).
# This module configures the system bootloader using systemd-boot,
# which provides a modern, secure, and feature-rich boot experience.

{
  boot.loader = {
    # Enable systemd-boot as the bootloader
    systemd-boot.enable = true;

    # Allow systemd-boot to modify EFI variables
    # This is required for managing boot entries and boot order
    efi.canTouchEfiVariables = true;
  };
}
