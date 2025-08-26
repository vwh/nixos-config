# Nix-ld configuration for running non-Nix binaries.
# This module enables nix-ld, which allows running dynamically linked
# executables that were not built for NixOS by providing common shared libraries.

{ pkgsStable, ... }:

{
  programs.nix-ld = {
    enable = true;

    libraries = with pkgsStable; [
      # Core system libraries
      stdenv.cc.cc
      libgcc
      glibc

      # Compression and crypto
      zlib
      bzip2
      xz
      openssl

      # X11 and graphics
      xorg.libX11
      xorg.libXext
      xorg.libXi
      xorg.libXrender
      xorg.libXft
      xorg.libXcursor
      xorg.libXrandr
      xorg.libXinerama
      libGL

      # System services
      dbus
      systemd

      # Text and fonts
      fontconfig
      freetype
      expat

      # Development libraries
      libffi
      ncurses
      readline

      # Network
      curl
      libxml2
      nss
      nspr
    ];
  };
}
