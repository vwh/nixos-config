# Tor service configuration for privacy and anonymity.

{ config, lib, ... }:

{
  # Custom module options for Tor configuration
  options.mySystem.tor = {
    enable = lib.mkEnableOption "Tor service for privacy and anonymity";
  };

  # Configuration applied when Tor is enabled
  config = lib.mkIf config.mySystem.tor.enable {
    services.tor = {
      enable = true; # Enable Tor daemon
      torsocks.enable = true; # Enable torsocks for transparent Tor routing
      client.enable = true; # Enable Tor client functionality

      # Configure DNS to use Tor's DNS resolver
      settings = {
        # Use Tor's internal DNS resolver to prevent leaks
        DNSPort = 9053;
        AutomapHostsOnResolve = true;
        AutomapHostsSuffixes = [
          ".onion"
          ".exit"
          ".noconnect"
        ];

        # Only use exit nodes in safe jurisdictions
        ExitNodes = "{de},{nl},{ch},{fi},{is},{ro}";

        # Disable IPv6 for better anonymity
        IPv6Exit = false;

        # Strict isolation for different circuits
        StrictNodes = 1;

        # Reduce fingerprinting
        UseEntryGuards = 1;
        NumEntryGuards = 3;
        NumDirectoryGuards = 3;
      };
    };
  };
}
