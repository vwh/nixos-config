# List of networking tools to install.

{ pkgsStable, ... }:

with pkgsStable;
[
  openssl
  openssl.dev
  openssh # SSH
  networkmanager # Network manager
  networkmanagerapplet # Network manager applet
]
