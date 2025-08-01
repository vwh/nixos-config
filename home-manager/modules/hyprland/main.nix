# Main Hyprland compositor settings.

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;

    settings = {
      env = [
        # Hint Electron apps to use Wayland
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland"
        "XDG_SCREENSHOTS_DIR,$HOME/screens"
      ];

      monitor = ",1920x1080@120,auto,1";
      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";
      "$browser" = "brave";
      "$editor" = "code";
      "$fileManager" = "thunar";
      "$menu" = "wofi";

      exec-once = [
        "waybar"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        # Auto-start apps in specific workspaces
        "[workspace 1 silent] $browser"
        "[workspace 2 silent] $terminal"
        "[workspace 2 silent] $editor"
        "[workspace 3 silent] telegram"
        "[workspace 4 silent] spotify"

        "sleep 1 && pyprland" # Start pyprland daemon
        # Better notifications
        "wl-paste -t text --watch clipman store"
        "wl-paste -p -t text --watch clipman store -P --histpath=\"~/.local/share/clipman-primary.json\""
      ];

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 5;

        "col.active_border" = "rgba(d65d0eff) rgba(98971aff) 45deg";
        "col.inactive_border" = "rgba(3c3836ff)";

        resize_on_border = true;
        allow_tearing = false;
        layout = "master";
      };

      decoration = {

        # Subtle shadows for depth
        shadow = {
          enabled = true;
          range = 8;
          render_power = 2;
          color = "rgba(0, 0, 0, 0.3)";
          color_inactive = "rgba(0, 0, 0, 0.2)";
        };

        # Performance-friendly blur
        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          ignore_opacity = true;
          new_optimizations = true;
          xray = true;
        };
      };

      # Better mouse behavior
      input = {
        kb_layout = "us,ara";
        kb_options = "grp:caps_toggle";
        # ... existing settings ...
        follow_mouse = 2; # Focus on mouse enter
        float_switch_override_focus = 0;
        mouse_refocus = false;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          clickfinger_behavior = true;
          tap-to-click = true;
        };
      };

      # Smooth animations
      animations = {
        enabled = true;
        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
          "softAcDecel, 0.26, 0.26, 0.15, 1"
        ];
        animation = [
          "windows, 1, 3, fluent_decel, slide"
          "windowsOut, 1, 3, fluent_decel, slide"
          "windowsMove, 1, 2, softAcDecel"
          "workspaces, 1, 2, fluent_decel"
          "specialWorkspace, 1, 3, fluent_decel, slidevert"
          "layers, 1, 3, easeOutCirc"
          "layersIn, 1, 3, easeOutCirc, left"
          "layersOut, 1, 3, fluent_decel, right"
          "fade, 1, 3, fluent_decel"
          "border, 1, 2.5, easeOutCirc"
        ];
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_invert = false;
        workspace_swipe_forever = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "slave";
        new_on_top = true;
        mfact = 0.5;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      windowrulev2 = [
        "bordersize 0, floating:0, onworkspace:w[t1]"

        "float,class:(mpv)|(imv)|(showmethekey-gtk)"
        "move 990 60,size 900 170,pin,noinitialfocus,class:(showmethekey-gtk)"
        "noborder,nofocus,class:(showmethekey-gtk)"

        "workspace 1,class:($browser)"

        "workspace 3,class:(telegram)"
        "workspace 3,class:(vesktop)"

        "workspace 4,class:(spotify)"

        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        "opacity 0.0 override, class:^(xwaylandvideobridge)$"
        "noanim, class:^(xwaylandvideobridge)$"
        "noinitialfocus, class:^(xwaylandvideobridge)$"
        "maxsize 1 1, class:^(xwaylandvideobridge)$"
        "noblur, class:^(xwaylandvideobridge)$"
        "nofocus, class:^(xwaylandvideobridge)$"
        "float,class:^(scratchpad)$"
        "noanim,class:^(scratchpad)$"
        "pin,class:^(scratchpad)$"
        "size 80% 60%,class:^(scratchpad)$"
        "center,class:^(scratchpad)$"

        # Workspace rules for better organization
        # Development workspace
        "workspace 2, class:(code|Code|VSCodium|sublime_text|jetbrains-*)"
        "workspace 2, class:(Alacritty), title:^(nvim|vim|hx)"

        # Media workspace
        "workspace 4, class:(mpv|vlc|spotify|rhythmbox)"

        # Documents workspace
        "workspace special:docs, class:(libreoffice|soffice|zathura|evince|okular)"

        # Picture-in-Picture
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "size 30% 30%, title:^(Picture-in-Picture)$"
        "move 69% 69%, title:^(Picture-in-Picture)$"

        # Better popup handling
        "float, class:^(pavucontrol|nm-connection-editor|blueman-manager)$"
        "center, class:^(pavucontrol|nm-connection-editor|blueman-manager)$"
        "size 60% 70%, class:^(pavucontrol|nm-connection-editor|blueman-manager)$"

        # Transparency for terminals
        "opacity 0.95 0.85, class:^(Alacritty|kitty|foot)$"

        # No animations for tooltips
        "noanim, class:^(tooltip)$"
      ];

      # Special workspaces for organization
      workspace = [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
        "special:terminal, on-created-empty:$terminal"
        "special:files, on-created-empty:$fileManager"
        "special:music, on-created-empty:spotify"
      ];
    };
  };
}
