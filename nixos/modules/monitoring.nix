# System monitoring and health services

{ pkgsStable, ... }:

{
  services = {
    # Periodic system cleanup
    cron = {
      enable = true;
      systemCronJobs = [
        "0 2 * * * root nix-collect-garbage --delete-older-than 30d"
        "0 3 * * * root nix store optimise"
      ];
    };
  };

  environment.systemPackages = with pkgsStable; [
    btop
    iotop
    ncdu
    sysstat
    lm_sensors
  ];
}
