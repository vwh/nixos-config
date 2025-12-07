# GNOME core services configuration for Hyprland.

{
  services = {
    displayManager.gdm.enable = true; # Enable GDM for graphical login
    desktopManager.gnome.enable = false; # Disable GNOME desktop - using Hyprland
    gnome.gnome-keyring.enable = true; # Enable GNOME keyring for password storage
  };

  # Enable GNOME keyring PAM module for authentication
  security.pam.services.gnome-keyring = {
    enable = true;
  };
}
