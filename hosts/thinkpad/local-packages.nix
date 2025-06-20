{ pkgs, pkgsStable, ... }:
{
  environment.systemPackages = with pkgs; [
    fwupd # BIOS/EC firmware updates
  ];
}
