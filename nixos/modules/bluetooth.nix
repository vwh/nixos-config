{ pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [ blueman ];
}
