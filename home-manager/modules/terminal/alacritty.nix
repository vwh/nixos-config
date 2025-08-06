# Alacritty terminal emulator configuration.

{ lib, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      # Window configuration
      window = {
        opacity = lib.mkForce 0.95; # Slight transparency for modern look
        blur = true; # Enable background blur
        padding = {
          x = 8;
          y = 8;
        };
        dynamic_padding = true;
        decorations = "full";
        startup_mode = "Windowed";
        title = "Alacritty";
        class = {
          instance = "Alacritty";
          general = "Alacritty";
        };
      };

      # Scrolling
      scrolling = {
        history = 50000; # Increased from default 10k
        multiplier = 3; # Scroll speed
      };

      # Font configuration
      font = {
        builtin_box_drawing = true;

        normal = {
          family = "JetBrains Mono";
          style = lib.mkForce "Bold";
        };

        bold = {
          family = "JetBrains Mono";
          style = "ExtraBold";
        };

        italic = {
          family = "JetBrains Mono";
          style = "Italic";
        };

        bold_italic = {
          family = "JetBrains Mono";
          style = "BoldItalic";
        };

        size = lib.mkForce 13.0;

        offset = {
          x = 0;
          y = 1; # Slight vertical offset for better readability
        };
      };

      # Gruvbox Dark color scheme (override Stylix)
      colors = lib.mkForce {
        primary = {
          background = "#282828"; # Gruvbox dark background
          foreground = "#ebdbb2"; # Gruvbox light foreground
          dim_foreground = "#a89984";
          bright_foreground = "#fbf1c7";
        };

        cursor = {
          text = "#282828";
          cursor = "#ebdbb2";
        };

        vi_mode_cursor = {
          text = "#282828";
          cursor = "#d65d0e"; # Orange cursor in vi mode
        };

        search = {
          matches = {
            foreground = "#282828";
            background = "#d79921"; # Yellow highlight
          };
          focused_match = {
            foreground = "#282828";
            background = "#fe8019"; # Orange focused match
          };
        };

        hints = {
          start = {
            foreground = "#282828";
            background = "#d79921";
          };
          end = {
            foreground = "#282828";
            background = "#fe8019";
          };
        };

        line_indicator = {
          foreground = "None";
          background = "None";
        };

        footer_bar = {
          foreground = "#ebdbb2";
          background = "#3c3836";
        };

        selection = {
          text = "#282828";
          background = "#ebdbb2";
        };

        normal = {
          black = "#282828";
          red = "#cc241d";
          green = "#98971a";
          yellow = "#d79921";
          blue = "#458588";
          magenta = "#b16286";
          cyan = "#689d6a";
          white = "#a89984";
        };

        bright = {
          black = "#928374";
          red = "#fb4934";
          green = "#b8bb26";
          yellow = "#fabd2f";
          blue = "#83a598";
          magenta = "#d3869b";
          cyan = "#8ec07c";
          white = "#ebdbb2";
        };

        dim = {
          black = "#1d2021";
          red = "#9d0006";
          green = "#79740e";
          yellow = "#b57614";
          blue = "#076678";
          magenta = "#8f3f71";
          cyan = "#427b58";
          white = "#928374";
        };
      };

      # Bell configuration
      bell = {
        animation = "EaseOutExpo";
        duration = 100;
        color = "#d79921"; # Yellow bell
      };

      # Selection
      selection = {
        semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
        save_to_clipboard = true;
      };

      # Cursor
      cursor = {
        style = {
          shape = "Block";
          blinking = "On";
        };
        blink_interval = 750;
        unfocused_hollow = true;
        thickness = 0.15;
      };

      # Live config reload (updated syntax)
      general.live_config_reload = true;

      # Terminal shell configuration
      terminal.shell = {
        program = "zsh";
        args = [ "-l" ];
      };

      # Working directory
      working_directory = "None";

      # Mouse
      mouse = {
        hide_when_typing = true;
        bindings = [
          {
            mouse = "Right";
            action = "PasteSelection";
          }
        ];
      };

      # Key bindings
      keyboard.bindings = [
        # Copy/Paste
        {
          key = "C";
          mods = "Control|Shift";
          action = "Copy";
        }
        {
          key = "V";
          mods = "Control|Shift";
          action = "Paste";
        }

        # Search
        {
          key = "F";
          mods = "Control|Shift";
          action = "SearchForward";
        }
        {
          key = "B";
          mods = "Control|Shift";
          action = "SearchBackward";
        }

        # Font size
        {
          key = "Plus";
          mods = "Control";
          action = "IncreaseFontSize";
        }
        {
          key = "Minus";
          mods = "Control";
          action = "DecreaseFontSize";
        }
        {
          key = "Key0";
          mods = "Control";
          action = "ResetFontSize";
        }

        # Scrolling
        {
          key = "PageUp";
          mods = "Shift";
          action = "ScrollPageUp";
        }
        {
          key = "PageDown";
          mods = "Shift";
          action = "ScrollPageDown";
        }
        {
          key = "Home";
          mods = "Shift";
          action = "ScrollToTop";
        }
        {
          key = "End";
          mods = "Shift";
          action = "ScrollToBottom";
        }

        # Vi mode
        {
          key = "Space";
          mods = "Control|Shift";
          action = "ToggleViMode";
        }

        # New instance
        {
          key = "N";
          mods = "Control|Shift";
          action = "SpawnNewInstance";
        }

        # Clear screen
        {
          key = "L";
          mods = "Control";
          chars = "\u000c";
        }
      ];

      # Hints (URL/path detection) - simplified to avoid TOML escaping issues
      hints = {
        enabled = [
          {
            regex = "https?://[a-zA-Z0-9._~:/?#@!$&'()*+,;=-]+";
            hyperlinks = true;
            post_processing = true;
            persist = false;
            action = "Copy";
            binding = {
              key = "U";
              mods = "Control|Shift";
            };
            mouse = {
              enabled = true;
              mods = "None";
            };
          }
        ];
      };

      # Debug
      debug = {
        render_timer = false;
        persistent_logging = false;
        log_level = "Warn";
        print_events = false;
      };
    };
  };
}
