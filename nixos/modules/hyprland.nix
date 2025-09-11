# Hyprland Wayland compositor configuration.
# This module configures Hyprland as the Wayland window manager with
# Universal Wayland Session Manager (UWSM) and necessary security services.

{ inputs, pkgs, ... }:

{
  programs.hyprland = {
    enable = true; # Enable Hyprland window manager
    withUWSM = true; # Enable Universal Wayland Session Manager for better session handling

    # Use the latest Hyprland from the flake input
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;

    # Use the matching XDG desktop portal for Hyprland
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Enable security services required by Hyprland
  security = {
    polkit.enable = true; # Enable PolicyKit for privilege escalation

    # PAM services for authentication
    pam.services = {
      hyprlock = { }; # PAM service for Hyprland screen locker
      gdm.enableGnomeKeyring = true; # Enable GNOME keyring with GDM
    };
  };

  # Enable XDG desktop portal for proper clipboard and file dialog support
  xdg.portal = {
    enable = true;
    wlr.enable = true; # Enable wlroots portal
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; # GTK portal for file dialogs
  };
}
