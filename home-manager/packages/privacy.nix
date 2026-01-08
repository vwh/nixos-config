# Privacy and opsec tools for anonymous browsing, secure communication,
# metadata removal, and network privacy.

{ pkgs, pkgsStable }:

[
  # === Privacy-Focused Browsers ===
  pkgs.librewolf # Privacy-focused Firefox fork (use latest)
  pkgsStable.tor # Tor client and service
  pkgsStable.tor-browser # Tor Browser Bundle

  # === DNS Privacy ===
  pkgsStable.dnscrypt-proxy # Encrypted DNS client
  pkgsStable.unbound # Validating recursive DNS resolver

  # === Network Anonymity ===
  pkgsStable.i2pd # I2P anonymous network
  pkgsStable.onionshare # Secure file sharing via Tor
  pkgsStable.tribler # Anonymous BitTorrent client

  # === Metadata Removal ===
  pkgsStable.mat2 # Metadata removal tool (anonymization framework)
  pkgsStable.exiftool # Read/write metadata in files

  # === Secure Communication ===
  pkgs.signal-desktop # Encrypted messaging (use latest)
  pkgsStable.wire-desktop # Secure messenger

  # === Password and Key Management ===
  pkgsStable.keepassxc # Cross-platform password manager
  pkgsStable.veracrypt # Disk encryption
  pkgsStable.socat # Network relay tool

  # === Network Analysis ===
  pkgsStable.nmap # Network discovery and security auditing
  pkgsStable.tcpdump # Network packet analyzer
]
