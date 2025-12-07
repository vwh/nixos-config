# X server configuration.

{
  services.xserver = {
    enable = true; # Enable the X.Org X server for XWayland compatibility
    # Note: Keyboard layout is configured in i18n.nix with mkForce for consistency
  };
}
