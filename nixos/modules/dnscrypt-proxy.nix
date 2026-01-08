# DNSCrypt-Proxy configuration for encrypted DNS.
# Provides DNS over HTTPS/TLS to prevent DNS leaks and improve privacy.

{ config, lib, ... }:

{
  # Custom module options for DNSCrypt-Proxy configuration
  options.mySystem.dnscryptProxy = {
    enable = lib.mkEnableOption "DNSCrypt-Proxy for encrypted DNS and DNS leak prevention";
  };

  # Configuration applied when DNSCrypt-Proxy is enabled
  config = lib.mkIf config.mySystem.dnscryptProxy.enable {
    # Enable DNSCrypt-Proxy service
    services.dnscrypt-proxy = {
      enable = true;

      settings = {
        # Listen on localhost for DNS queries
        listen_addresses = [ "127.0.0.1:53" ];

        # Server names to use (encrypted DNS resolvers)
        server_names = [
          "cloudflare"
          "cloudflare-security"
        ];

        # SECURITY: Use bootstrap resolvers only for initial connection
        # These are ONLY used to resolve DoH server addresses, not for regular queries
        bootstrap_resolvers = [
          "1.1.1.1:53"
          "1.0.0.1:53"
        ];

        # PRIVACY: Disable fallback to prevent DNS leaks
        # If encrypted DNS fails, queries will fail rather than leak
        fallback_resolvers = [ ];
        ignore_system_dns = true;

        # Cache settings
        cache = true;
        cache_size = 512;
        cache_min_ttl = 600;
        cache_max_ttl = 86400;

        # Require DNSSEC and no logging
        require_dnssec = true;
        require_nolog = true;
        require_nofilter = false; # Allow filtering resolvers

        # Logging (reduced for privacy)
        log_level = 2;
        log_file = "/var/log/dnscrypt-proxy/dnscrypt-proxy.log";

        # Block IPv6 to prevent leaks (matches Tor config)
        block_ipv6 = true;
      };
    };
  };
}
