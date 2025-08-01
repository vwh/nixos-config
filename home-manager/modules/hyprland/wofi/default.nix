# Wofi (application launcher) configuration.

{
  programs.wofi = {
    enable = true;

    settings = {
      # Appearance
      allow_images = true;
      image_size = 32;
      width = 420;
      height = 520;
      location = "center";
      orientation = "vertical";
      halign = "fill";

      # Behavior
      show = "drun,run";
      prompt = "Search";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      show_all = false;
      print_command = true;
      layer = "overlay";
      insensitive = true;

      # Performance
      parse_search = true;
      search = "";

      # Modes
      modes = "drun,run";

      # Advanced
      matching = "contains";
      hide_scroll = true;
      dynamic_lines = false;

      # Key bindings
      key_expand = "Tab";
      key_exit = "Escape";
    };
  };

  home.file.".config/wofi/style.css".source = ./style.css;
}
