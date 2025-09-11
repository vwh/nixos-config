# X server configuration.
# This module configures the X.Org X server for traditional X11 applications,

{
  services.xserver = {
    enable = true; # Enable the X.Org X server for XWayland compatibility
    # Note: Keyboard layout is configured in i18n.nix with mkForce for consistency
  };
}
