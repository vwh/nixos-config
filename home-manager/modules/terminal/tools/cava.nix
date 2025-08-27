# Cava audio visualizer configuration.
# This module configures cava, a console-based audio visualizer

{
  programs.cava = {
    enable = true; # Enable cava audio visualizer

    settings = {
      general = {
        framerate = 60; # Visualizer refresh rate (Hz)
        sensitivity = 80; # Audio sensitivity level
        autosens = 1; # Enable automatic sensitivity adjustment
      };

      # Color configuration with Gruvbox theme
      color = {
        gradient = 1; # Enable gradient color mode

        # Gruvbox color palette for the visualizer
        gradient_color_1 = "'#ebdbb2'"; # Light foreground
        gradient_color_2 = "'#d65d0e'"; # Orange
        gradient_color_3 = "'#fabd2f'"; # Yellow
        gradient_color_4 = "'#8ec07c'"; # Green
        gradient_color_5 = "'#83a598'"; # Aqua
        gradient_color_6 = "'#d3869b'"; # Purple
        gradient_color_7 = "'#fb4934'"; # Red
        gradient_color_8 = "'#fe8019'"; # Bright orange
      };
    };
  };
}
