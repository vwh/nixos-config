# Hyprland keybinds and custom scripts.
# This module defines custom keybindings for Hyprland window manager

{ pkgsStable, ... }:

let
  # Directory containing e-book files
  booksDir = "$HOME/Downloads/books";

  # Custom script to open books using wofi menu
  booksScript = pkgsStable.writeScriptBin "open_books" ''
    #!/bin/sh

    BOOKS_DIR="${booksDir}"

    # Find all book files and present them in a menu
    BOOK=$(find "$BOOKS_DIR" -type f \( -iname "*.pdf" -o -iname "*.epub" -o -iname "*.djvu" \) | wofi --dmenu --prompt "Select a book" --width 1200 --height 400)

    if [[ -n "$BOOK" ]]; then
        zathura "$BOOK" &  # Open selected book with zathura
    else
        echo "No book selected."
    fi
  '';

  # Custom script for switching between windows using wofi menu
  windowSwitcher = pkgsStable.writeScriptBin "window-switcher" ''
    #!/bin/sh
    # Get list of all windows with workspace, class, and title information
    windows=$(hyprctl clients -j | jq -r '.[] | "\(.workspace.id):\(.workspace.name) - \(.class) - \(.title)"')
    selected=$(echo "$windows" | wofi --dmenu --prompt "Switch to window" --width 800)

    if [[ -n "$selected" ]]; then
      # Find the window address and focus it
      address=$(hyprctl clients -j | jq -r --arg sel "$selected" '.[] | select("\(.workspace.id):\(.workspace.name) - \(.class) - \(.title)" == $sel) | .address')
      hyprctl dispatch focuswindow "address:$address"
    fi
  '';

  # Simple screenshot script using grim+slurp only
  screenshotScript = pkgsStable.writeScriptBin "smart-screenshot" ''
    #!${pkgsStable.bash}/bin/bash
    # Screenshot using grim+slurp - the standard Wayland tools

    SCREENSHOT_DIR="$HOME/screens"
    mkdir -p "$SCREENSHOT_DIR"

    # Function to take screenshot
    take_screenshot() {
        local mode="$1"

        case "$mode" in
            "region")
                # Region selection with slurp
                region=$(slurp 2>/dev/null)
                if [[ -n "$region" ]]; then
                    if grim -g "$region" - | wl-copy; then
                        notify-send "Screenshot" "Region saved to clipboard" -t 2000
                    else
                        notify-send "Screenshot" "Failed to capture region" -t 2000
                    fi
                else
                    notify-send "Screenshot" "Region selection cancelled" -t 2000
                fi
                ;;
            "window")
                # Active window
                window_geometry=$(hyprctl activewindow -j 2>/dev/null | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' 2>/dev/null)
                if [[ -n "$window_geometry" ]] && [[ "$window_geometry" != "null" ]]; then
                    if grim -g "$window_geometry" - | wl-copy; then
                        notify-send "Screenshot" "Window saved to clipboard" -t 2000
                    else
                        notify-send "Screenshot" "Failed to capture window" -t 2000
                    fi
                else
                    notify-send "Screenshot" "Failed to get window geometry" -t 2000
                fi
                ;;
            "active")
                # Active monitor
                monitor=$(hyprctl monitors -j 2>/dev/null | jq -r '.[] | select(.focused) | .name' 2>/dev/null)
                if [[ -n "$monitor" ]] && [[ "$monitor" != "null" ]]; then
                    if grim -o "$monitor" - | wl-copy; then
                        notify-send "Screenshot" "Active screen saved to clipboard" -t 2000
                    else
                        notify-send "Screenshot" "Failed to capture screen" -t 2000
                    fi
                else
                    notify-send "Screenshot" "Failed to get active monitor" -t 2000
                fi
                ;;
            *)
                echo "Usage: smart-screenshot {region|window|active}"
                exit 1
                ;;
        esac
    }

    take_screenshot "$1"
  '';
in
{
  # Install custom scripts as system packages
  home.packages = [
    booksScript # Book selection script
    windowSwitcher # Window switcher script
    screenshotScript # Smart screenshot script with timeout
  ];

  wayland.windowManager.hyprland.settings = {
    # Regular keybindings (pressed once)
    bind = [
      # Custom window switcher menu
      "$mainMod, W, exec, ${windowSwitcher}/bin/window-switcher"

      # Window focus cycling with Tab
      "$mainMod, Tab, cyclenext," # Next window
      "$mainMod SHIFT, Tab, cyclenext, prev" # Previous window

      # Window positioning and appearance
      "$mainMod, C, centerwindow," # Center floating window

      # Window opacity controls
      "$mainMod, O, exec, hyprctl keyword decoration:active_opacity 0.8" # Semi-transparent
      "$mainMod SHIFT, O, exec, hyprctl keyword decoration:active_opacity 1.0" # Fully opaque

      # Window swapping
      "$mainMod, S, swapnext," # Swap with next window
      "$mainMod SHIFT, S, swapnext, prev" # Swap with previous window

      # Master layout management
      "$mainMod, comma, layoutmsg, swapwithmaster" # Swap with master window
      "$mainMod, period, layoutmsg, focusmaster" # Focus master window
      "$mainMod SHIFT, comma, layoutmsg, addmaster" # Add window to master area
      "$mainMod SHIFT, period, layoutmsg, removemaster" # Remove window from master area

      # Layout orientation controls
      "$mainMod, I, layoutmsg, orientationtop" # Top orientation (horizontal)
      "$mainMod SHIFT, I, layoutmsg, orientationleft" # Left orientation (vertical)
      "$mainMod CTRL, I, layoutmsg, orientationcenter" # Center orientation

      # Layout switching between tiling algorithms
      "$mainMod, L, exec, hyprctl keyword general:layout dwindle" # Switch to dwindle layout
      "$mainMod SHIFT, L, exec, hyprctl keyword general:layout master" # Switch to master layout

      # Quick workspace navigation
      "$mainMod, U, exec, hyprctl dispatch workspace previous" # Switch to previous workspace

      # Window grouping controls
      "$mainMod, G, togglegroup," # Toggle window grouping
      "$mainMod SHIFT, G, moveoutofgroup," # Move window out of group

      # Color picker utility
      "$mainMod, P, exec, hyprpicker -a && notify-send 'Color copied'" # Pick color and notify

      # Session management
      "$mainMod SHIFT, Escape, exit," # Exit Hyprland
      "$mainMod, Home, exec, loginctl lock-session" # Lock session

      # Application shortcuts
      "$mainMod, Return, exec, $terminal" # Launch terminal
      "$mainMod, T, exec, $terminal --class=scratchpad" # Launch terminal as scratchpad

      # Window management
      "$mainMod, Q, killactive," # Close active window
      "$mainMod SHIFT, R, exec, $fileManager" # Open file manager
      "$mainMod, R, exec, env -u TMUX alacritty -e yazi" # Open file browser in terminal
      "$mainMod, F, togglefloating," # Toggle floating mode
      "$mainMod, D, exec, $menu --show drun" # Application launcher
      "$mainMod, V, exec, cliphist list | $menu --dmenu | cliphist decode | wl-copy" # Clipboard manager
      "$mainMod, M, fullscreen," # Toggle fullscreen

      # Advanced window controls
      "$mainMod, A, pin," # Pin window (always on top)

      # Web browser shortcuts
      "$mainMod, B, exec, zen" # Launch Zen browser

      # Utility shortcuts
      "$mainMod, E, exec, bemoji -cn" # Emoji picker
      "$mainMod, N, exec, swaync-client -t" # Notification center

      # Waybar controls
      "$mainMod, K, exec, pkill -SIGUSR2 waybar" # Reload waybar
      "$mainMod SHIFT, K, exec, pkill -SIGUSR1 waybar" # Toggle waybar
      # "$mainMod, W, exec, ${booksScript}/bin/open_books"   # Book selector (commented out)

      # Screenshot functionality
      ", Print, exec, ${screenshotScript}/bin/smart-screenshot region" # Screenshot region selection
      "$mainMod SHIFT, Print, exec, ${screenshotScript}/bin/smart-screenshot window" # Screenshot active window
      "$mainMod CTRL, Print, exec, ${screenshotScript}/bin/smart-screenshot active" # Screenshot active screen

      # Volume control
      "$mainMod, equal,  exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      "$mainMod, minus, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

      # Keyboard layout and caps lock fixes
      "$mainMod, F12, exec, hyprctl switchxkblayout current next" # Manual layout switch
      "$mainMod SHIFT, F12, exec, hyprctl switchxkblayout current prev" # Reverse layout switch
      "$mainMod, Escape, exec, hyprctl keyword input:kb_options 'grp:caps_toggle'" # Reset caps lock

      # Moving focus
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      # Moving windows
      "$mainMod SHIFT, left,  swapwindow, l"
      "$mainMod SHIFT, right, swapwindow, r"
      "$mainMod SHIFT, up,    swapwindow, u"
      "$mainMod SHIFT, down,  swapwindow, d"

      # Resizeing windows                   X  Y
      "$mainMod CTRL, left,  resizeactive, -60 0"
      "$mainMod CTRL, right, resizeactive,  60 0"
      "$mainMod CTRL, up,    resizeactive,  0 -60"
      "$mainMod CTRL, down,  resizeactive,  0  60"

      # Switching workspaces
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"

      # Quick workspace navigation
      "$mainMod, grave, workspace, previous" # Last workspace

      # Moving windows to workspaces
      "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
      "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
      "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
      "$mainMod SHIFT, 4, movetoworkspacesilent, 4"

      # Scratchpad
      "$mainMod,       X, togglespecialworkspace,  magic"
      "$mainMod SHIFT, X, movetoworkspace, special:magic"

      # "$mainMod, bracketleft, workspace, m-1" # Previous workspace
      # "$mainMod, bracketright, workspace, m+1" # Next workspace
    ];

    # Mouse bindings for window manipulation
    bindm = [
      "$mainMod, mouse:272, movewindow" # Move window with Super + Left mouse button
      "$mainMod, mouse:273, resizewindow" # Resize window with Super + Right mouse button
    ];

    # Multimedia keys (repeat when held)
    bindel = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+" # Volume up
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" # Volume down
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" # Mute toggle
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle" # Mic mute toggle
      "$mainMod, bracketright, exec, brightnessctl s 10%+" # Brightness up
      "$mainMod, bracketleft, exec, brightnessctl s 10%-" # Brightness down
    ];

    # Media playback keys (non-repeating)
    bindl = [
      ", XF86AudioNext, exec, playerctl next" # Next track
      ", XF86AudioPause, exec, playerctl play-pause" # Play/pause
      ", XF86AudioPlay, exec, playerctl play-pause" # Play/pause (alternative)
      ", XF86AudioPrev, exec, playerctl previous" # Previous track
    ];
  };
}
