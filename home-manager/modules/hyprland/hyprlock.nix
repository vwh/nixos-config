# Hyprlock (screen locker) configuration.
# This module configures Hyprlock, a GPU-accelerated screen locker for Hyprland
# with customizable appearance, animations, and authentication methods.

{
  programs.hyprlock = {
    enable = true; # Enable Hyprlock screen locker

    settings = {
      # General lock screen settings
      general = {
        grace = 10; # Grace period before locking (seconds)
        hide_cursor = true; # Hide cursor when locked
        no_fade_in = false; # Enable fade-in animation
      };

      # Time display label configuration
      label = {
        text = "$TIME"; # Display current time
        font_size = 96; # Large font size
        font_family = "JetBrains Mono"; # Monospace font
        color = "rgba(235, 219, 178, 1.0)"; # Gruvbox light color
        position = "0, 600"; # Position on screen
        halign = "center"; # Horizontal alignment
        walign = "center"; # Vertical alignment
        shadow_passes = 1; # Enable text shadow
      };

      # Background configuration with blur effect
      background = [
        {
          path = "screenshot"; # Use current screen as background
          blur_passes = 3; # Number of blur passes
          blur_size = 8; # Blur kernel size
        }
      ];

      # Password input field configuration
      input-field = [
        {
          size = "200, 50"; # Input field dimensions
          position = "0, -80"; # Position relative to center
          monitor = ""; # Use all monitors
          dots_center = true; # Center password dots
          font_color = "rgb(235, 219, 178)"; # Input text color
          inner_color = "rgb(40, 40, 40)"; # Input field background
          outer_color = "rgb(60, 56, 54)"; # Input field border
          outline_thickness = 5; # Border thickness
          placeholder_text = "Enter password"; # Placeholder text
          shadow_passes = 1; # Enable input field shadow
        }
      ];
    };
  };
}
