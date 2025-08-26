# ThinkPad host-specific modules aggregation.
# This module imports all host-specific configurations for the ThinkPad,
# including boot settings, NVIDIA graphics, power management, and TLP.

{
  imports = [
    ./boot.nix # Boot loader and kernel parameters
    ./nvidia.nix # NVIDIA graphics driver configuration
    ./power.nix # Power management settings
    ./tlp.nix # TLP power management daemon
  ];
}
