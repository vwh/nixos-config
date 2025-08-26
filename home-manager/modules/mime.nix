# MIME type associations for default applications.
# This module configures XDG MIME type associations to ensure files open with the correct applications.

{ lib, ... }:

with lib;

# Default application mappings for different file categories
let
  defaultApps = {
    browser = [ "zen.desktop" ]; # Web browser for HTML and URLs
    text = [ "org.gnome.TextEditor.desktop" ]; # Plain text editor
    image = [ "imv.desktop" ]; # Image viewer
    audio = [ "mpv.desktop" ]; # Audio player
    video = [ "mpv.desktop" ]; # Video player
    directory = [ "nautilus.desktop" ]; # File manager
    office = [ "libreoffice.desktop" ]; # Office suite
    pdf = [ "zathura.desktop" ]; # PDF viewer
    terminal = [ "alacritty.desktop" ]; # Terminal emulator
    archive = [ "xarchiver.desktop" ]; # Archive manager
  };

  # MIME type mappings - maps file categories to specific MIME types
  mimeMap = {
    # Plain text files
    text = [ "text/plain" ];

    # Image formats
    image = [
      "image/bmp" # Windows Bitmap
      "image/gif" # GIF images
      "image/jpeg" # JPEG images
      "image/jpg" # JPG images
      "image/png" # PNG images
      "image/svg+xml" # SVG vector graphics
      "image/tiff" # TIFF images
      "image/vnd.microsoft.icon" # Windows icons
      "image/webp" # WebP images
    ];

    # Audio formats
    audio = [
      "audio/aac" # AAC audio
      "audio/mpeg" # MP3 audio
      "audio/ogg" # OGG audio
      "audio/opus" # Opus audio
      "audio/wav" # WAV audio
      "audio/webm" # WebM audio
      "audio/x-matroska" # Matroska audio
    ];

    # Video formats
    video = [
      "video/mp2t" # MPEG-2 transport stream
      "video/mp4" # MP4 video
      "video/mpeg" # MPEG video
      "video/ogg" # OGG video
      "video/webm" # WebM video
      "video/x-flv" # Flash video
      "video/x-matroska" # Matroska video
      "video/x-msvideo" # AVI video
    ];

    # Directories
    directory = [ "inode/directory" ];

    # Web and URL schemes
    browser = [
      "text/html" # HTML files
      "x-scheme-handler/about" # about: URLs
      "x-scheme-handler/http" # HTTP URLs
      "x-scheme-handler/https" # HTTPS URLs
      "x-scheme-handler/unknown" # Unknown schemes
    ];

    # Office document formats
    office = [
      "application/vnd.oasis.opendocument.text" # ODT files
      "application/vnd.oasis.opendocument.spreadsheet" # ODS files
      "application/vnd.oasis.opendocument.presentation" # ODP files
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" # DOCX files
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" # XLSX files
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" # PPTX files
      "application/msword" # DOC files
      "application/vnd.ms-excel" # XLS files
      "application/vnd.ms-powerpoint" # PPT files
      "application/rtf" # RTF files
    ];

    # Document formats
    pdf = [ "application/pdf" ]; # PDF documents

    # Terminal and shell
    terminal = [ "terminal" ]; # Terminal applications

    # Archive formats
    archive = [
      "application/zip" # ZIP archives
      "application/rar" # RAR archives
      "application/7z" # 7Z archives
      "application/*tar" # TAR archives (various)
    ];
  };

  # Generate associations by flattening MIME type mappings with their default applications
  associations =
    with lists;
    listToAttrs (
      flatten (mapAttrsToList (key: map (type: attrsets.nameValuePair type defaultApps."${key}")) mimeMap)
    );
in
{
  # XDG MIME applications configuration
  xdg = {
    # Force override of existing mimeapps.list to ensure our associations take precedence
    configFile."mimeapps.list".force = true;

    mimeApps = {
      enable = true;
      # Add our custom associations
      associations.added = associations;
      # Set as default applications for these MIME types
      defaultApplications = associations;
    };
  };
}
