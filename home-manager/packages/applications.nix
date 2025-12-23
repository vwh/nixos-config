# General application packages.
# This module provides essential desktop applications including browsers,
# communication tools, productivity software, and theming packages.

{ pkgs, pkgsStable }:

(with pkgsStable; [
  libreoffice-qt6-fresh # Full office suite with Qt6 interface

  # Privacy and security applications
  tor-browser # Anonymous web browser via Tor network
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

  # Communication and collaboration tools
  element-desktop # Matrix protocol client for Element
  vesktop # Enhanced Discord client
  telegram-desktop # Telegram messaging application
  slack # Slack team communication platform
  teams-for-linux # Microsoft Teams for Linux
  remmina # Remote desktop client

  # Productivity and knowledge management
  anki-bin # Spaced repetition flashcard system
  obsidian # Knowledge base and note-taking application
  antigravity-fhs # AI-powered agentic IDE

  # Gaming and compatibility tools
  (bottles.override { removeWarningPopup = true; }) # Run Windows applications on Linux

  youtube-music # YouTube Music desktop client
])
