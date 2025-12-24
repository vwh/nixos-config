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

    # Archive management
    file-roller

    # Thumbnail and preview support
    gst_all_1.gst-plugins-good # GStreamer plugins for media thumbnails
    gst_all_1.gst-plugins-bad # Additional GStreamer plugins
    poppler-utils # PDF thumbnail generation
    ffmpegthumbnailer # Video thumbnail generation
    gnome-epub-thumbnailer # EPUB and book preview thumbnails
    sushi # Quick file previews with spacebar

    # Image viewer
    loupe # Modern GNOME image viewer
  ];

  # Combine all services into a single block
  services = {
    # Enable GVFS for Trash, SFTP, and other virtual file systems
    gvfs = {
      enable = true;
      package = pkgsStable.gnome.gvfs;
    };

    # Enable thumbnailing service
    tumbler.enable = true;

    # Enable udisks2 for automatic device mounting
    udisks2.enable = true;
  };

  # PolicyKit rule for passwordless mounting by wheel group members
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if ((action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
           action.id == "org.freedesktop.udisks2.filesystem-mount") &&
          subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';
}
