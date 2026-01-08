# General desktop applications including browsers, communication tools,
# productivity software, and theming packages.

{ pkgs, pkgsStable }:

[
  # === Web Browsers ===
  pkgs.brave # Privacy-focused web browser (use latest)
  pkgs.firefox # Mozilla Firefox web browser

  # === Communication and Collaboration ===
  pkgs.vesktop # Enhanced Discord client
  pkgs.telegram-desktop # Telegram messaging application
  pkgsStable.teams-for-linux # Microsoft Teams for Linux
  pkgsStable.remmina # Remote desktop client

  # === Productivity and Knowledge Management ===
  pkgs.obsidian # Knowledge base and note-taking application
  pkgsStable.libreoffice-qt6-fresh # Full office suite with Qt6 interface

  # === AI and Development Tools ===
  pkgs.antigravity-fhs # AI-powered agentic IDE

  # === Gaming and Compatibility ===
  (pkgs.bottles.override { removeWarningPopup = true; }) # Run Windows applications on Linux

  # === Music and Media ===
  pkgs.pear-desktop # YouTube Music desktop client (formerly youtube-music)

  # === Desktop Theming ===
  pkgsStable.gruvbox-gtk-theme # Gruvbox color scheme for GTK applications
  pkgsStable.gruvbox-kvantum # Gruvbox theme for Qt applications
  pkgsStable.gnome-themes-extra # Additional GTK themes and base themes
]
