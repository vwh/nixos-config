# List of multimedia packages to install.

{ pkgs, ... }:

with pkgs;
[
  mpv # Video player
  imv # Image viewer
  feh # Image viewer
  ffmpeg # Media player
  ffmpegthumbnailer # Generate thumbnails
  mediainfo # Media information
]
