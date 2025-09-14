# XDG Desktop Portal Configuration
# This module provides proper configuration for xdg-desktop-portal services

{ pkgs, ... }:

{
  # Install xdg-desktop-portal and related packages
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    xdg-utils
  ];

  # Set default portal implementations
  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "GNOME";
    XDG_SESSION_DESKTOP = "GNOME";
    XDG_SESSION_TYPE = "wayland";
    GTK_USE_PORTAL = "1";
  };

  # Configure portal implementations
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
    config = {
      common = {
        default = [
          "gtk"
          "wlr"
        ];
        "org.freedesktop.impl.portal.Screenshot" = "wlr";
        "org.freedesktop.impl.portal.ScreenCast" = "wlr";
        "org.freedesktop.impl.portal.FileChooser" = "gtk";
      };
    };
  };
}
