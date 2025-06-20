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

  services = {
    power-profiles-daemon.enable = false;
    throttled.enable = lib.mkDefault true;
    
    tlp = {
    enable = true;
      # settings = {
      #   RESTORE_DEVICE_STATE_ON_STARTUP = "1";
      #   SCHED_POWERSAVE_ON_AC           = "0";
      #   SCHED_POWERSAVE_ON_BAT          = "1";
      #   USB_AUTOSUSPEND                 = "1";
      #   NVM_EXP_POWER_SMART             = "1";
      #   BLUETOOTH_AUTO_ENABLE           = "1";
      # };
    };
  };

  networking.hostName = hostname;

  system = {
    stateVersion = stateVersion;
    autoUpgrade.enable = true;
    autoUpgrade.dates = "weekly";
  };

  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };

    # integrated
    intelBusId = "PCI:0@2:0:0";

    # dedicated
    nvidiaBusId = "PCI:2@0:0:0";
  };
}
