# Tor service configuration.

{
  services.tor = {
    enable = true;
    torsocks.enable = true;
    client.enable = true;
  };
}
