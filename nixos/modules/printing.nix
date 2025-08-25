# Printing services configuration.

{ pkgsStable, ... }:

{
  # Enable CUPS printing service
  services.printing = {
    enable = true;
    drivers = [ pkgsStable.foo2zjs ]; # Driver for HP LaserJet P1102
  };

  # Enable network discovery for printers (optional but recommended)
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Open firewall ports for CUPS
  networking.firewall = {
    allowedTCPPorts = [ 631 ];
    allowedUDPPorts = [ 631 ];
  };

  # Note: HP LaserJet P1102 will be configured manually via CUPS web interface
}
