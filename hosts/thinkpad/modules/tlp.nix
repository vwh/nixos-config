# TLP (Linux Advanced Power Management) configuration for ThinkPad.
# This module configures TLP, a power management daemon that optimizes
# power consumption and performance on laptops, with settings tuned for ThinkPad hardware.

{
  services = {
    tlp = {
      enable = true; # Enable TLP power management daemon

      settings = {
        # CPU frequency scaling governor settings
        CPU_SCALING_GOVERNOR_ON_AC = "schedutil"; # Balanced governor on AC power
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil"; # Balanced governor on battery

        # CPU energy performance policy
        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power"; # Balanced power/performance on AC
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power"; # Balanced power/performance on battery

        # Platform power profile settings
        PLATFORM_PROFILE_ON_AC = "low-power"; # Low power profile on AC
        PLATFORM_PROFILE_ON_BAT = "low-power"; # Low power profile on battery

        # USB device exclusions
        USB_EXCLUDE_BTUSB = 1; # Exclude Bluetooth USB devices from autosuspend

        # AMD Radeon graphics power management
        RADEON_DPM_PERF_LEVEL_ON_AC = "auto"; # Automatic performance level on AC
        RADEON_DPM_PERF_LEVEL_ON_BAT = "auto"; # Automatic performance level on battery

        # Disk I/O scheduler settings
        DISK_IOSCHED = [ "none" ]; # Use none scheduler for SSDs

        # Battery charge thresholds for on-road usage
        # Keeps battery between 85-90% to extend battery lifespan
        START_CHARGE_THRESH_BAT0 = 85; # Start charging at 85%
        STOP_CHARGE_THRESH_BAT0 = 90; # Stop charging at 90%
      };
    };
  };
}
