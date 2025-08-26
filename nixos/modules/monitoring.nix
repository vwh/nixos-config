# System monitoring and health services.
# This module configures system monitoring tools and automated maintenance
# tasks for optimal system performance and health.

{ pkgsStable, ... }:

{
  services = {
    # Periodic system cleanup and maintenance
    cron = {
      enable = true; # Enable cron daemon for scheduled tasks
      systemCronJobs = [
        "0 2 * * * root nix-collect-garbage --delete-older-than 30d" # Clean old Nix generations daily at 2 AM
        "0 3 * * * root nix store optimise" # Optimize Nix store daily at 3 AM
      ];
    };
  };

  # System monitoring and diagnostic tools
  environment.systemPackages = with pkgsStable; [
    btop # Modern system monitor (htop alternative)
    iotop # I/O usage monitor
    ncdu # Disk usage analyzer
    sysstat # System performance monitoring tools
    lm_sensors # Hardware sensor monitoring
  ];
}
