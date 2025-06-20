{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ blueman ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  services.blueman.enable = true;
}
