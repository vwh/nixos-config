# Multimedia and media processing packages.
# This module provides essential tools for media playback, image viewing,
# video processing, and media information analysis.

{ pkgsStable, ... }:

with pkgsStable;
[
  mpv # Advanced video player with extensive features
  imv # Minimalist image viewer for Wayland
  feh # Lightweight image viewer for X11
  ffmpeg # Complete multimedia processing toolkit
  ffmpegthumbnailer # Video thumbnail generator for file managers
  mediainfo # Media file information analyzer
]
