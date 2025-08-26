# Boot loader and kernel configuration for ThinkPad.
# This module configures boot parameters specific to ThinkPad hardware,
# including backlight control and ACPI settings for optimal functionality.

{
  boot.kernelParams = [
    # Force use of the thinkpad_acpi driver for backlight control
    # This allows the backlight save/load systemd service to work properly
    # and provides better backlight control on ThinkPad laptops
    "acpi_backlight=native"
  ];
}
