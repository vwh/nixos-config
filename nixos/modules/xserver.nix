# X server configuration.
# This module configures the X.Org X server for traditional X11 applications,

{
  services.xserver = {
    enable = true; # Enable the X.Org X server

    # Keyboard layout configuration for X11
    xkb = {
      layout = "us"; # US English keyboard layout
      variant = ""; # Default variant (empty for standard layout)
    };
  };
}
