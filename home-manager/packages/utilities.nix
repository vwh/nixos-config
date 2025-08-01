# List of utility packages to install.

{ pkgsStable, ... }:

with pkgsStable;
[
  coreutils # Linux core utilities
  findutils # GNU find, xargs, locate
  diffutils # GNU diff
  gzip # GNU gzip
  unzip # GNU zip
  xdg-utils # xdg utilities
  desktop-file-utils # desktop file utilities
  optipng # optimize PNG files
  jpegoptim # optimize JPEG files
  libsecret # password manager
  sops # encrypted secrets
  pavucontrol # PulseAudio volume control
  ueberzugpp # terminal image viewer
  udisks # automount USB, SD cards, pmount, …
  xarchiver # archive manager
  lm_sensors # hardware monitoringc
]
