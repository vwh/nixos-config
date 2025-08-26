# PC host-specific modules aggregation.
# This module imports all host-specific configurations for the PC,
# including power management and hardware-specific settings.

{
  imports = [
    ./power.nix # Power management and performance settings
  ];
}
