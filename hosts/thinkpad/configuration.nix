# Main NixOS configuration for the 'thinkpad' host.

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

  boot.kernelParams = [
    # Force use of the thinkpad_acpi driver for backlight control.
    # This allows the backlight save/load systemd service to work.
    "acpi_backlight=native"
  ];

  networking.hostName = hostname;
  powerManagement.enable = true;
  programs.gamemode.enable = false;

  services = {
    power-profiles-daemon.enable = false;
    throttled.enable = lib.mkDefault true;
    libinput.enable = true;

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

        USB_AUTOSUSPEND = 1;
        PCIE_ASPM_ON_BAT = "powersupersave";
        WIFI_PWR_ON_BAT = 5;
        RUNTIME_PM_ON_BAT = "auto";
        SOUND_POWER_SAVE_ON_BAT = 1;
        DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth";
      };
    };
  };

  system = {
    inherit stateVersion;
    autoUpgrade.enable = true;
    autoUpgrade.dates = "weekly";
  };

  hardware.nvidia = {
    powerManagement = {
      finegrained = true; # More precise power consumption control
    };

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      sync.enable = false;

      # Integrated
      intelBusId = "PCI:0@2:0:0";

      # Dedicated
      nvidiaBusId = "PCI:2@0:0:0";
    };
  };

  environment.systemPackages = [ pkgs.home-manager ];
}
