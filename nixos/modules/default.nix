# Imports all NixOS modules.
# This file serves as the central hub for importing all system-wide
# configuration modules that define the complete NixOS system.

{
  imports = [
    ./audio.nix # Audio system configuration (PipeWire/PulseAudio)
    ./bluetooth.nix # Bluetooth services and device management
    ./bootloader.nix # Boot loader configuration (GRUB/systemd-boot)
    ./browser-deps.nix # Browser dependencies for Chrome/Chromium-based applications
    ./cleanup.nix # Automated file cleanup services
    ./nautilus.nix # GNOME Files (Nautilus) configuration
    ./nh.nix # Nix Helper (nh) configuration
    ./environment.nix # System-wide environment variables and paths
    ./gaming.nix # Gaming-related configurations and optimizations
    ./gnome.nix # GNOME desktop environment configuration
    ./graphics.nix # Graphics drivers and GPU configuration
    ./hyprland.nix # Hyprland window manager system integration
    ./i18n.nix # Internationalization and localization settings
    ./libinput.nix # Input device configuration (touchpad, mouse, etc.)
    ./networking.nix # Network configuration and firewall rules
    ./nix-ld.nix # Dynamic linker for running non-Nix binaries
    ./nix.nix # Nix package manager configuration
    ./ollama.nix # Ollama service for local AI models and embeddings
    ./printing.nix # CUPS printing system and drivers
    ./qdrant.nix # Qdrant vector search engine for AI code indexing
    ./sops.nix # Secret management with SOPS
    ./stability.nix # System stability and optimization settings
    ./timezone.nix # Time zone and clock configuration
    ./tor.nix # Tor network services and configuration
    ./upower.nix # Power management and battery monitoring
    ./users.nix # User account management and permissions
    ./virtualisation.nix # Virtualization support (QEMU, libvirt, etc.)
    ./xdg-desktop-portal.nix # XDG desktop portal configuration
    ./xserver.nix # X11 server configuration and display settings
  ];
}
