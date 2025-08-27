# Main Hyprland compositor settings.
# This module configures the Hyprland Wayland compositor with custom keybindings,
# window rules, animations, and workspace management.

{ pkgsStable, ... }:

{
  # Enable Hyprland window manager with systemd integration
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;

    settings = {
      # Environment variables for proper Wayland and application integration
      env = [
        "ELECTRON_OZONE_PLATFORM_HINT,auto" # Hint Electron apps to use Wayland
        "XDG_CURRENT_DESKTOP,Hyprland" # Set current desktop for XDG compliance
        "XDG_SESSION_TYPE,wayland" # Indicate Wayland session
        "XDG_SESSION_DESKTOP,Hyprland" # Set session desktop
        "QT_QPA_PLATFORM,wayland" # Force Qt applications to use Wayland
        "GTK_THEME=Gruvbox-Dark" # Set GTK theme for consistency
        "QT_STYLE_OVERRIDE=kvantum" # Use Kvantum Qt style
        "XDG_SCREENSHOTS_DIR,$HOME/screens" # Directory for screenshots
      ];

      # Monitor configuration
      monitor = ",preferred,auto,1";

      # Variable definitions for keybindings and commands
      "$mainMod" = "SUPER"; # Main modifier key (Windows/Cmd key)
      "$terminal" = "alacritty"; # Default terminal emulator
      "$browser" = "zen"; # Default web browser
      "$editor" = "code"; # Default code editor
      "$fileManager" = "nautilus"; # Default file manager
      "$menu" = "wofi"; # Application launcher menu

      # Applications to start once when Hyprland launches
      exec-once = [
        "waybar" # Status bar
        "wl-paste --type text --watch cliphist store" # Clipboard manager for text
        "wl-paste --type image --watch cliphist store" # Clipboard manager for images

        # Auto-start applications in specific workspaces
        "[workspace 1 silent] $browser" # Browser in workspace 1
        "[workspace 2 silent] $terminal" # Terminal in workspace 2
        "[workspace 2 silent] $editor" # Editor in workspace 2
        "[workspace 3 silent] Telegram" # Telegram in workspace 3
        "[workspace 4 silent] spotify" # Spotify in workspace 4

        # Enhanced clipboard management
        "wl-paste -t text --watch clipman store" # Primary clipboard
        "wl-paste -p -t text --watch clipman store -P --histpath=\"~/.local/share/clipman-primary.json\""
      ];

      # General Hyprland settings
      general = {
        gaps_in = 0; # Inner window gaps
        gaps_out = 0; # Outer window gaps
        border_size = 5; # Window border width

        # Border colors with gradient
        "col.active_border" = "rgba(d65d0eff) rgba(98971aff) 45deg";
        "col.inactive_border" = "rgba(3c3836ff)";

        resize_on_border = true; # Allow resizing by dragging borders
        allow_tearing = false; # Prevent display tearing
        layout = "master"; # Use master layout (tiling)
      };

      # Window decoration settings
      decoration = {
        # Shadow effects for window depth
        shadow = {
          enabled = true;
          range = 8; # Shadow spread distance
          render_power = 2; # Shadow rendering quality
          color = "rgba(0, 0, 0, 0.3)"; # Active window shadow color
          color_inactive = "rgba(0, 0, 0, 0.2)"; # Inactive window shadow color
        };

        # Blur effects for modern look
        blur = {
          enabled = true;
          size = 3; # Blur kernel size
          passes = 2; # Number of blur passes
          ignore_opacity = false; # Respect window opacity
          new_optimizations = true; # Use newer blur optimizations
          xray = false; # Don't blur transparent windows
          special = false; # Don't blur special workspaces
        };
      };

      # Input device configuration
      input = {
        # Keyboard layout configuration (US + Arabic)
        kb_layout = "us,ara";
        kb_variant = ",qwerty";
        kb_options = "grp:caps_toggle,grp_led:caps,terminate:ctrl_alt_bksp";

        # Mouse behavior settings
        follow_mouse = 2; # Focus window on mouse enter
        float_switch_override_focus = 0; # Don't override focus for floating windows
        mouse_refocus = false; # Don't refocus on mouse movement

        # Keyboard repeat settings
        repeat_rate = 25; # Characters per second
        repeat_delay = 600; # Delay before repeat starts (ms)

        # Additional keyboard settings
        numlock_by_default = true; # Enable numlock by default
        force_no_accel = false; # Allow mouse acceleration

        # Touchpad configuration
        touchpad = {
          natural_scroll = true; # Natural scrolling direction
          disable_while_typing = true; # Disable touchpad while typing
          clickfinger_behavior = true; # Enable tap-to-click
          tap-to-click = true; # Enable tap-to-click
        };
      };

      # Animation configuration for smooth transitions
      animations = {
        enabled = true;

        # Custom easing curves for different animation types
        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1" # Fluent deceleration curve
          "easeOutCirc, 0, 0.55, 0.45, 1" # Circular easing out
          "easeOutExpo, 0.16, 1, 0.3, 1" # Exponential easing out
          "softAcDecel, 0.26, 0.26, 0.15, 1" # Soft acceleration/deceleration
        ];

        # Animation rules for different window events
        animation = [
          "windows, 1, 3, fluent_decel, slide" # Window open/close
          "windowsOut, 1, 3, fluent_decel, slide" # Window close
          "windowsMove, 1, 2, softAcDecel" # Window movement
          "workspaces, 0, 0, fluent_decel" # Workspace switching
          "specialWorkspace, 1, 3, fluent_decel, slidevert" # Special workspace
          "layers, 1, 3, easeOutCirc" # Layer transitions
          "layersIn, 1, 3, easeOutCirc, left" # Layer in animation
          "layersOut, 1, 3, fluent_decel, right" # Layer out animation
          "fade, 1, 3, fluent_decel" # Fade transitions
          "border, 1, 2.5, easeOutCirc" # Border animations
        ];
      };

      # Touchpad gesture configuration
      gestures = {
        workspace_swipe = true; # Enable workspace switching with swipe
        workspace_swipe_invert = false; # Don't invert swipe direction
        workspace_swipe_forever = true; # Allow continuous swiping
      };

      # Dwindle layout configuration (tiling algorithm)
      dwindle = {
        pseudotile = true; # Enable pseudotiling for some windows
        preserve_split = true; # Keep split ratios when toggling
        smart_split = false; # Don't use smart splitting
        smart_resizing = true; # Enable smart resizing
        force_split = 0; # 0 = split follows mouse, 1 = always right/bottom, 2 = always left/top
        default_split_ratio = 1.0; # Default split ratio
        use_active_for_splits = true; # Use active window for split calculations
        split_width_multiplier = 1.0; # Width multiplier for splits
      };

      # Master layout configuration (alternative to dwindle)
      master = {
        new_status = "slave"; # New windows become slaves
        new_on_top = true; # New windows appear on top
        mfact = 0.55; # Master window takes 55% of screen space
        orientation = "left"; # Default to vertical split (master on left)
        inherit_fullscreen = true; # Slave windows inherit fullscreen
        smart_resizing = true; # Enable smart resizing
        drop_at_cursor = true; # Drop new windows at cursor position
      };

      # Miscellaneous settings
      misc = {
        force_default_wallpaper = 0; # Don't force default wallpaper
        disable_hyprland_logo = true; # Disable Hyprland logo on startup
      };

      # Window rules for specific application behavior
      windowrulev2 = [
        # Special workspace rules
        "bordersize 0, floating:0, onworkspace:w[t1]" # No borders on special workspace

        # Media and utility applications
        "float,class:(mpv)|(imv)|(showmethekey-gtk)" # Float media players and utilities
        "move 990 60,size 900 170,pin,noinitialfocus,class:(showmethekey-gtk)"
        "noborder,nofocus,class:(showmethekey-gtk)"

        # Key display utilities (use `hyprctl clients` to find window info)
        "float,class:^(one.alynx.showmethekey)$"
        "float,class:^(showmethekey-gtk)$" # Make window floating
        "pin,class:^(showmethekey-gtk)$" # Pin window to stay visible

        # Workspace assignments
        "workspace 1,class:($browser)" # Browser to workspace 1
        "workspace 3,class:(Telegram)" # Telegram to workspace 3
        "workspace 3,class:(vesktop)" # Discord client to workspace 3
        "workspace 4,class:(spotify)" # Spotify to workspace 4

        # General window behavior
        "suppressevent maximize, class:.*" # Disable maximize for all windows
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        # XWayland video bridge (fixes screen sharing)
        "opacity 0.0 override, class:^(xwaylandvideobridge)$"
        "noanim, class:^(xwaylandvideobridge)$"
        "noinitialfocus, class:^(xwaylandvideobridge)$"
        "maxsize 1 1, class:^(xwaylandvideobridge)$"
        "noblur, class:^(xwaylandvideobridge)$"
        "nofocus, class:^(xwaylandvideobridge)$"

        # Scratchpad configuration
        "float,class:^(scratchpad)$"
        "noanim,class:^(scratchpad)$"
        "pin,class:^(scratchpad)$"
        "size 80% 60%,class:^(scratchpad)$"
        "center,class:^(scratchpad)$"

        # Media workspace assignments
        "workspace 4, class:(mpv|vlc|spotify|rhythmbox)"

        # Documents workspace assignments
        "workspace special:docs, class:(libreoffice|soffice|zathura|evince|okular)"

        # Picture-in-Picture handling
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "size 30% 30%, title:^(Picture-in-Picture)$"
        "move 69% 69%, title:^(Picture-in-Picture)$"

        # System popups and dialogs
        "float, class:^(pavucontrol|nm-connection-editor|blueman-manager)$"
        "center, class:^(pavucontrol|nm-connection-editor|blueman-manager)$"
        "size 60% 70%, class:^(pavucontrol|nm-connection-editor|blueman-manager)$"

        # Transparency settings
        "opacity 0.95 0.85, class:^(Alacritty|kitty|foot)$" # Terminal transparency
        "opacity 0.95, class:(zen)" # Browser transparency

        # Performance optimizations
        "noanim, class:^(tooltip)$" # Disable animations for tooltips
      ];

      # Special workspace configurations
      workspace = [
        "w[tv1], gapsout:0, gapsin:0" # TV workspace with no gaps
        "f[1], gapsout:0, gapsin:0" # Floating workspace with no gaps
        "special:terminal, on-created-empty:$terminal" # Terminal special workspace
        "special:files, on-created-empty:$fileManager" # Files special workspace
        "special:music, on-created-empty:spotify" # Music special workspace
      ];
    };
  };
}
