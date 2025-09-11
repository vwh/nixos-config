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
      glib # Added for Chrome/Chromium support

      # Compression and crypto
      zlib
      bzip2
      xz
      openssl

      # Printing support (needed by Chrome)
      cups

      # XCB protocol library (needed by Chrome)
      xorg.libxcb

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

      # Additional X11 libraries for Chrome/Chromium
      xorg.libXcomposite
      xorg.libXdamage
      xorg.libXfixes
      xorg.libXScrnSaver
      xorg.libXtst
      xorg.libxkbfile
      xorg.libxshmfence

      # System services
      dbus
      systemd

      # Text and fonts
      fontconfig
      freetype
      expat

      # Additional libraries for Chrome/Chromium
      atk
      at-spi2-atk
      cairo
      gdk-pixbuf
      gtk3
      pango
      alsa-lib
      libdrm
      libxkbcommon
      mesa
      libgbm

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
