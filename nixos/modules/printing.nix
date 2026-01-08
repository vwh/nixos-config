# Printing services configuration.

{ pkgsStable, ... }:

{
  # Enable CUPS printing service
  services.printing = {
    enable = true;
    drivers = [ pkgsStable.foo2zjs ]; # Driver for HP LaserJet P1102
    listenAddresses = [ "127.0.0.1:631" ]; # Restrict to localhost for security
    allowFrom = [ "localhost" ]; # Only allow local connections
  };

  # Enable network discovery for printers (local only)
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = false; # Don't expose Avahi to network

    # Optimize avahi startup to prevent PID file conflicts
    package = pkgsStable.avahi;
  };

  # NOTE: CUPS ports removed from firewall for security
  # Only local printing is supported. For network printing, explicitly add ports.
  # networking.firewall = {
  #   allowedTCPPorts = [ 631 ];
  #   allowedUDPPorts = [ 631 ];
  # };

  # Note: HP LaserJet P1102 will be configured manually via CUPS web interface
}
