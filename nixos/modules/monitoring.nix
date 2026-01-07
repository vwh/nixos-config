# System monitoring configuration.
# This module enables hardware sensor monitoring and provides tools for
# monitoring system resources, temperatures, and performance metrics.

{ pkgsStable, ... }:

{
  # Intel thermal daemon disabled on ThinkPad
  # (conflicts with TLP - TLP handles thermal management better)
  # Note: Enable thermald on non-ThinkPad systems if needed
  # services.thermald.enable = true;

  # System monitoring and diagnostic tools
  environment.systemPackages = with pkgsStable; [
    btop # Modern system monitor (htop alternative)
    iotop # I/O usage monitor
    ncdu # Disk usage analyzer
    sysstat # System performance monitoring tools
    lm_sensors # Hardware sensor monitoring

    # Power monitoring tools for ThinkPad
    powertop # Power consumption analysis and optimization
    acpi # ACPI battery and power information
    tpacpi-bat # ThinkPad battery utilities
  ];
}
