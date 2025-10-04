# Wofi (application launcher) configuration.

{ user, ... }:

{
  programs.wofi = {
    enable = true; # Enable Wofi application launcher

    settings = {
      # Visual appearance settings
      allow_images = true; # Show application icons
      image_size = 24; # Reduced icon size for better performance
      width = 400; # Window width
      height = 400; # Reduced window height for faster rendering
      location = "center"; # Window position on screen
      orientation = "vertical"; # Layout orientation
      halign = "fill"; # Horizontal alignment

      # User interaction behavior
      show = "drun"; # Desktop apps only (faster than drun,run)
      prompt = "Search"; # Input prompt text
      filter_rate = 50; # Reduced filtering rate for better responsiveness
      allow_markup = false; # Disable markup for better performance
      no_actions = true; # Hide context actions
      show_all = false; # Don't show all results by default
      print_command = true; # Print selected command to stdout
      layer = "overlay"; # Window layer (overlay on desktop)
      insensitive = true; # Case-insensitive search

      # Performance optimizations
      parse_search = true; # Parse search terms
      search = ""; # Default search text
      cache_file = "/home/${user}/.cache/wofi_cache"; # Enable caching for faster startup
      term = "alacritty"; # Default terminal

      # Available search modes
      modes = "drun"; # Desktop applications only for better performance

      # Advanced search and display options
      matching = "fuzzy"; # Faster fuzzy matching instead of contains
      hide_scroll = true; # Hide scroll bar
      dynamic_lines = false; # Fixed number of lines
      lines = 15; # Limit number of visible lines for better performance

      # Keyboard shortcuts
      key_expand = "Tab"; # Key to expand selection
      key_exit = "Escape"; # Key to exit launcher
    };
  };

  # Install custom CSS styling for Wofi
  home.file.".config/wofi/style.css".source = ./style.css;
}
