{ pkgs, ... }:

with pkgs;
[
  openssl
  openssl.dev
  openssh
  networkmanager
  networkmanagerapplet
]
