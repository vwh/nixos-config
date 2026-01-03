# General desktop applications including browsers, communication tools,
# productivity software, and theming packages.

{ pkgs, pkgsStable }:

with pkgs;
with pkgsStable;
[
  # === Web Browsers ===
  brave # Privacy-focused web browser
  firefox # Mozilla Firefox web browser

  # === Communication and Collaboration ===
  element-desktop # Matrix protocol client for Element
  vesktop # Enhanced Discord client
  telegram-desktop # Telegram messaging application
  slack # Slack team communication platform
  teams-for-linux # Microsoft Teams for Linux
  remmina # Remote desktop client

  # === Productivity and Knowledge Management ===
  anki-bin # Spaced repetition flashcard system
  obsidian # Knowledge base and note-taking application
  libreoffice-qt6-fresh # Full office suite with Qt6 interface

  # === AI and Development Tools ===
  antigravity-fhs # AI-powered agentic IDE

  # === Gaming and Compatibility ===
  (bottles.override { removeWarningPopup = true; }) # Run Windows applications on Linux

  # === Music and Media ===
  youtube-music # YouTube Music desktop client

  # === Desktop Theming ===
  gruvbox-gtk-theme # Gruvbox color scheme for GTK applications
  gruvbox-kvantum # Gruvbox theme for Qt applications
  gnome-themes-extra # Additional GTK themes and base themes

  # === VPN Services ===
  protonvpn-gui # ProtonVPN graphical client
]
