# Imports all Home Manager modules.
# This file serves as the central hub for importing all user-specific

{
  imports = [
    ./apps # Application-specific configurations (browsers, editors, etc.)
    ./hyprland # Hyprland window manager and related services
    ./languages # Programming languages configurations
    ./terminal # Terminal emulator and shell configurations
    ./overlays.nix # Nix package overlays for customizations
    ./gpg.nix # GPG key management and configuration
    ./mime.nix # MIME type associations and default applications
    ./qt.nix # Qt theming and configuration
    ./stylix.nix # System theming and styling
    ./mise.nix # Mise runtime manager configuration
  ];
}
