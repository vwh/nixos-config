# Nautilus (GNOME Files) configuration.
# This module configures the GNOME Files file manager with enhanced features
# including thumbnail support, automounting, and theming integration.

{ pkgsStable, ... }:

{
  # File manager and related packages
  environment.systemPackages = with pkgsStable; [
    # Core Nautilus file manager
    nautilus # GNOME Files application
    nautilus-python # Python extensions support

    # Thumbnail and preview support
    gst_all_1.gst-plugins-good # GStreamer plugins for media thumbnails
    poppler_utils # PDF thumbnail generation
    ffmpegthumbnailer # Video thumbnail generation
    gnome-epub-thumbnailer # EPUB and book preview thumbnails
    sushi # Quick file previews on hover
  ];

  # Enable udisks2 for automatic device mounting
  systemd.services.udisks2.enable = true;

  # PolicyKit rule for passwordless mounting by wheel group members
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.freedesktop.udisks2.filesystem-mount-system" &&
          subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  # Force Gruvbox dark theme for consistency
  environment.variables = {
    GTK_THEME = "Gruvbox-Dark"; # Ensure consistent theming
  };
}
