# Wofi (application launcher) configuration.
# This module configures Wofi, a lightweight Wayland application launcher
# and menu system that provides fuzzy searching and application discovery
# with customizable appearance and behavior.

{
  # Enable Wofi application launcher
  programs.wofi = {
    enable = true;

    settings = {
      # Visual appearance settings
      allow_images = true; # Show application icons
      image_size = 32; # Icon size in pixels
      width = 420; # Window width
      height = 520; # Window height
      location = "center"; # Window position on screen
      orientation = "vertical"; # Layout orientation
      halign = "fill"; # Horizontal alignment

      # User interaction behavior
      show = "drun,run"; # Available modes (desktop apps + commands)
      prompt = "Search"; # Input prompt text
      filter_rate = 100; # Search filtering rate
      allow_markup = true; # Allow text markup in results
      no_actions = true; # Hide context actions
      show_all = false; # Don't show all results by default
      print_command = true; # Print selected command to stdout
      layer = "overlay"; # Window layer (overlay on desktop)
      insensitive = true; # Case-insensitive search

      # Performance optimizations
      parse_search = true; # Parse search terms
      search = ""; # Default search text

      # Available search modes
      modes = "drun,run"; # Desktop applications + executable commands

      # Advanced search and display options
      matching = "contains"; # Search matching algorithm
      hide_scroll = true; # Hide scroll bar
      dynamic_lines = false; # Fixed number of lines

      # Keyboard shortcuts
      key_expand = "Tab"; # Key to expand selection
      key_exit = "Escape"; # Key to exit launcher
    };
  };

  # Install custom CSS styling for Wofi
  home.file.".config/wofi/style.css".source = ./style.css;
}
