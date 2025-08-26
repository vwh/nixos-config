# GNOME display and desktop manager configuration.
# This module enables the GNOME desktop environment with GDM display manager
# and GNOME keyring for secure credential storage.

{
  services = {
    displayManager.gdm.enable = true; # Enable GNOME Display Manager (login screen)
    desktopManager.gnome.enable = true; # Enable GNOME desktop environment
    gnome.gnome-keyring.enable = true; # Enable GNOME keyring for password storage
  };
}
