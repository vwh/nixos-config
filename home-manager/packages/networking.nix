# Networking and network analysis tools.
# This module provides comprehensive networking utilities for network analysis,
# monitoring, debugging, security testing, and connectivity management.

{ pkgsStable, ... }:

with pkgsStable;
[
  # Core networking and security
  openssl # OpenSSL cryptographic library
  openssl.dev # OpenSSL development headers
  openssh # OpenSSH connectivity tools
  networkmanager # Network connection manager
  networkmanagerapplet # Network manager system tray

  # HTTP clients and download tools
  wget # File downloader
  curl # Command-line HTTP client
  httpie # Modern HTTP client with colors

  # Network scanning and reconnaissance
  nmap # Network discovery and security auditing
  masscan # Fast internet-scale port scanner
  zmap # Internet-wide network scanner

  # Network monitoring and analysis
  iftop # Real-time network bandwidth monitor
  nethogs # Network usage by process
  nload # Network load monitor
  vnstat # Network traffic statistics
  bandwhich # Network utilization by socket

  # DNS and domain utilities
  dnsutils # DNS utilities
  whois # Domain registration information

  # Network debugging and packet analysis
  tcpdump # Network packet capture and analyzer
  netcat # Networking utility for reading/writing network connections
  socat # Multipurpose relay tool for bidirectional data transfer

  # VPN and secure tunneling
  openvpn # OpenVPN client
  wireguard-tools # WireGuard VPN tools

  # Network performance and diagnostics
  iperf3 # Network bandwidth measurement
  mtr # Network diagnostic tool (traceroute + ping)
  traceroute # Network route tracing

  # Text-based web browsers
  lynx # Advanced text-based web browser
  w3m # Another text-based web browser

  # Network security and penetration testing
  hydra # Network login cracker
]
