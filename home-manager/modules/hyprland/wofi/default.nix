# Wofi (application launcher) configuration.

{ user, ... }:

{
  programs.wofi = {
    enable = true; # Enable Wofi application launcher

    settings = {
      # Visual appearance settings
      allow_images = true; # Show application icons
      image_size = 24; # Small icons for speed
      width = 400; # Window width
      height = 300;
      location = "center"; # Window position on screen
      orientation = "vertical"; # Layout orientation
      halign = "fill"; # Horizontal alignment

      # User interaction behavior
      show = "drun,run"; # Desktop apps + commands from PATH (including ~/.local/bin)
      prompt = "Search"; # Input prompt text
      filter_rate = 16; # 60fps response - MUCH faster than 50ms
      allow_markup = false; # Disable markup for better performance
      no_actions = true; # Hide context actions
      show_all = false; # Don't show all results by default
      print_command = true; # Print selected command to stdout
      layer = "overlay"; # Window layer (overlay on desktop)
      normal_window = true; # Use window animations (faster)
      insensitive = true; # Case-insensitive search

      # Performance optimizations
      parse_search = true; # Parse search terms
      search = ""; # Default search text
      cache_file = "/home/${user}/.cache/wofi_cache"; # Enable caching for faster startup
      term = "alacritty"; # Default terminal

      # Available search modes
      modes = "drun,run"; # Desktop apps + commands from PATH
      columns = 1; # Single column for performance

      # Advanced search and display options
      matching = "fuzzy"; # Faster fuzzy matching instead of contains
      hide_scroll = true; # Hide scroll bar
      dynamic_lines = false; # Fixed number of lines
      lines = 12;

      # Keyboard shortcuts
      key_expand = "Tab"; # Key to expand selection
      key_exit = "Escape"; # Key to exit launcher

      # Gruvbox dark theme optimization
      gtk_dark = true; # Force dark theme
    };
  };

  # Install custom CSS styling for Wofi
  home.file.".config/wofi/style.css".source = ./style.css;
}
