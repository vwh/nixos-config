# List of networking tools to install.

{ pkgsStable, ... }:

with pkgsStable;
[
  # Core networking
  openssl
  openssl.dev
  openssh # SSH
  networkmanager # Network manager
  networkmanagerapplet # Network manager applet

  # Network utilities
  wget # File downloader
  curl # HTTP client
  httpie # Modern HTTP client

  # Network analysis
  nmap # Network scanner
  masscan # Fast port scanner
  zmap # Internet-wide network scanner

  # Network monitoring
  iftop # Network bandwidth monitor
  nethogs # Network usage by process
  nload # Network load monitor
  vnstat # Network statistics
  bandwhich # Network utilization by process

  # DNS utilities
  dig # DNS lookup
  host # DNS lookup
  whois # Domain information

  # Network debugging
  tcpdump # Packet capture
  netcat # Network utility
  socat # Socket utility

  # VPN and tunneling
  openvpn # VPN client
  wireguard-tools # WireGuard VPN

  # Network testing
  iperf3 # Network performance testing
  mtr # Network diagnostic tool
  traceroute # Route tracing

  # Web utilities
  lynx # Text-based web browser
  w3m # Text-based web browser

  # Network security
  hydra # Password cracker
]
