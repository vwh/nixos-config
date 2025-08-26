# Internationalization (i18n) settings.
# This module configures locale settings, input methods, and keyboard layouts
# for multilingual support, particularly for English and Arabic.

{ pkgs, lib, ... }:

{
  i18n = {
    # Default system locale for most applications
    defaultLocale = "en_US.UTF-8";

    # Regional format settings for specific categories
    extraLocaleSettings = {
      LC_ADDRESS = "en_AG"; # Address format (Antigua/Barbuda)
      LC_IDENTIFICATION = "en_AG"; # Metadata about the locale
      LC_MEASUREMENT = "en_AG"; # Measurement units and formats
      LC_MONETARY = "en_AG"; # Currency and monetary formats
      LC_NAME = "en_AG"; # Name format conventions
      LC_NUMERIC = "en_AG"; # Number formatting
      LC_PAPER = "en_AG"; # Paper size standards
      LC_TELEPHONE = "en_AG"; # Telephone number formats
      LC_TIME = "en_AG"; # Date and time formats
    };

    # Input method configuration for multilingual text input
    inputMethod = {
      enable = true; # Enable input method framework
      type = "fcitx5"; # Use Fcitx5 input method engine

      fcitx5 = {
        waylandFrontend = true; # Enable Wayland support for Fcitx5

        # Additional input method addons and language support
        addons = with pkgs; [
          fcitx5-gtk # GTK integration for Fcitx5
          fcitx5-configtool # Configuration tool for Fcitx5
          fcitx5-chinese-addons # Chinese input methods
          fcitx5-anthy # Japanese input method
        ];
      };
    };
  };

  # Keyboard layout configuration for X11/Wayland
  services.xserver = {
    xkb = {
      layout = lib.mkForce "us,ara"; # US English + Arabic layouts
      variant = lib.mkForce ",qwerty"; # Default variants
      options = lib.mkForce "grp:caps_toggle,grp_led:caps"; # Caps lock toggles layout, LED indicates state
    };
  };

  # Environment variables for input method integration
  environment.sessionVariables = {
    QT_IM_MODULE = "fcitx"; # Qt input method module
    XMODIFIERS = "@im=fcitx"; # X11 input method modifier
    SDL_IM_MODULE = "fcitx"; # SDL input method module
    INPUT_METHOD = "fcitx"; # Default input method
    GLFW_IM_MODULE = "ibus"; # GLFW input method (fallback)
  };

  # Install additional input method packages
  environment.systemPackages = with pkgs; [
    fcitx5-with-addons # Complete Fcitx5 with all addons
    fcitx5-gtk # GTK integration
    fcitx5-configtool # Configuration GUI
  ];
}
