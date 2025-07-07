# List of networking tools to install.

{ pkgs, ... }:

with pkgs;
[
  openssl
  openssl.dev
  openssh # SSH
  networkmanager # Network manager
  networkmanagerapplet # Network manager applet
]
