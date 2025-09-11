# Browser dependencies for Chrome/Chromium-based applications.
# This module provides system libraries needed for Puppeteer and other Chrome-based tools.

{ pkgs, lib, ... }:

{
  # Add browser dependencies to system packages
  environment.systemPackages = with pkgs; [
    # Install Chromium directly
    chromium

    # Virtual display for headful mode
    xorg.xvfb
    xorg.xauth

    # Basic dependencies for Chrome/Chromium
    glib
    nss
    nspr
    atk
    at-spi2-atk
    cups
    dbus
    libdrm
    expat
    fontconfig
    freetype
    gdk-pixbuf
    gtk3
    pango
    cairo
    xorg.libX11
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXScrnSaver
    xorg.libXtst
    mesa
    alsa-lib
    libxkbcommon
    xorg.libxkbfile

    # Additional dependencies for newer Chrome versions
    xorg.libxshmfence
    libgbm

    # Additional libraries that might be needed
    stdenv.cc.cc.lib
  ];

  # Set environment variables for Chrome
  environment.variables = {
    # Disable Chrome sandbox warnings (useful in NixOS)
    CHROME_DEVEL_SANDBOX = "${pkgs.chromium}/bin/chrome-devel-sandbox";

    # Set library path for Puppeteer (include pipewire path and browser deps)
    LD_LIBRARY_PATH = lib.mkForce (
      "/nix/store/mkfrp29i8cwfxdplwacm1yxfqs50gprf-pipewire-1.4.7-jack/lib:"
      + "${pkgs.stdenv.cc.cc.lib}/lib:"
      + "${pkgs.glib}/lib:"
      + "${pkgs.nss}/lib:"
      + "${pkgs.nspr}/lib:"
      + "${pkgs.atk}/lib:"
      + "${pkgs.cairo}/lib:"
      + "${pkgs.pango}/lib:"
      + "${pkgs.gdk-pixbuf}/lib:"
      + "${pkgs.gtk3}/lib:"
      + "${pkgs.fontconfig}/lib:"
      + "${pkgs.freetype}/lib:"
      + "${pkgs.dbus}/lib:"
      + "${pkgs.expat}/lib:"
      + "${pkgs.alsa-lib}/lib:"
      + "${pkgs.mesa}/lib:"
      + "${pkgs.xorg.libX11}/lib:"
      + "${pkgs.xorg.libXcomposite}/lib:"
      + "${pkgs.xorg.libXcursor}/lib:"
      + "${pkgs.xorg.libXdamage}/lib:"
      + "${pkgs.xorg.libXext}/lib:"
      + "${pkgs.xorg.libXfixes}/lib:"
      + "${pkgs.xorg.libXi}/lib:"
      + "${pkgs.xorg.libXrandr}/lib:"
      + "${pkgs.xorg.libXrender}/lib:"
      + "${pkgs.xorg.libXScrnSaver}/lib:"
      + "${pkgs.xorg.libXtst}/lib:"
      + "${pkgs.libxkbcommon}/lib:"
      + "${pkgs.xorg.libxkbfile}/lib:"
      + "${pkgs.xorg.libxshmfence}/lib:"
      + "${pkgs.libgbm}/lib"
    );

    # Set Puppeteer to use headless mode by default
    PUPPETEER_HEADLESS = "new";
  };
}
