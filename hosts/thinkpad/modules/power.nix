# Power management and performance configuration for ThinkPad.
# This module configures power management settings optimized for ThinkPad
# laptops, including thermal throttling prevention and power profiles.

{
  # Enable NixOS power management
  powerManagement.enable = true;

  # Game mode configuration
  # Disabled to prevent automatic CPU governor changes during gaming
  programs.gamemode.enable = false;

  services = {
    # Disable power-profiles-daemon to avoid conflicts with TLP
    power-profiles-daemon.enable = false;

    # TLP is enabled in tlp.nix - disable conflicting services
    # to prevent system instability and improve power management

    # Disabled: throttled (conflicts with TLP)
    # Disabled: auto-cpufreq (conflicts with TLP)
  };

  # ThinkPad-specific kernel modules for battery control
  boot.kernelModules = [
    "acpi_call"
    "tp_smapi"
    "thinkpad_acpi"
  ];
}
