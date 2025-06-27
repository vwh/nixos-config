{ pkgs, pkgsStable, ... }:
{
  environment.systemPackages = with pkgs; [
    tlp
    smartmontools
    powertop
  ];
}
