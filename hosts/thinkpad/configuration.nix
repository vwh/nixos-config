{
  pkgs,
  stateVersion,
  hostname,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./local-packages.nix
    ../../nixos/modules
  ];

  environment.systemPackages = [ pkgs.home-manager ];

  boot.kernelParams = [
    # Force use of the thinkpad_acpi driver for backlight control.
    # This allows the backlight save/load systemd service to work.
    "acpi_backlight=native"
  ];

  powerManagement.enable = true;

  services = {
    power-profiles-daemon.enable = false;
    throttled.enable = lib.mkDefault true;

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;
      };
    };
  };

  networking.hostName = hostname;

  system = {
    inherit stateVersion;
    autoUpgrade.enable = true;
    autoUpgrade.dates = "weekly";
  };

  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };

    # Integrated
    intelBusId = "PCI:0@2:0:0";

    # Dedicated
    nvidiaBusId = "PCI:2@0:0:0";
  };
}
