# Browser dependencies for Chrome/Chromium-based applications.
# This module provides system libraries and environment settings needed for
# Puppeteer and other Chrome-based tools.

{ pkgs, ... }:

{
  # Add browser-related packages to system
  environment.systemPackages = with pkgs; [
    chromium

    # Virtual display for headful mode (useful for debugging and screenshots)
    xorg.xvfb
    xorg.xauth
  ];

  # Set environment variables for Chrome and Puppeteer
  environment.variables = {
    # Disable Chrome sandbox warnings
    CHROME_DEVEL_SANDBOX = "${pkgs.chromium}/bin/chrome-devel-sandbox";

    # Set Puppeteer to use headless mode by default
    PUPPETEER_HEADLESS = "new";

    # Set Chrome to use Ozone/Wayland when available
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
}
