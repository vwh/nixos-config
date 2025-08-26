# General application packages.
# This module provides essential desktop applications including browsers,
# communication tools, productivity software, and theming packages.

{ pkgs, pkgsStable }:

(with pkgsStable; [
  # Privacy and security applications
  tor-browser # Anonymous web browser via Tor network
  libreoffice-qt6-fresh # Full office suite with Qt6 interface
  protonvpn-gui # ProtonVPN graphical client

  # Desktop theming and appearance
  gruvbox-gtk-theme # Gruvbox color scheme for GTK applications
  gruvbox-kvantum # Gruvbox theme for Qt applications
  gnome-themes-extra # Additional GTK themes and base themes
])

++ (with pkgs; [
  # Web browsers
  brave # Privacy-focused web browser
  firefox # Mozilla Firefox web browser
  chromium # Open-source web browser

  # Communication and collaboration tools
  element-desktop # Matrix protocol client for Element
  vesktop # Enhanced Discord client
  telegram-desktop # Telegram messaging application
  slack # Slack team communication platform
  teams-for-linux # Microsoft Teams for Linux

  # Productivity and knowledge management
  anki # Spaced repetition flashcard system
  obsidian # Knowledge base and note-taking application
])
