# Hyprland keybinds and custom scripts.

{ pkgsStable, ... }:

let
  booksDir = "$HOME/Downloads/books";
  booksScript = pkgsStable.writeScriptBin "open_books" ''
    #!/bin/sh

    BOOKS_DIR="${booksDir}"

    BOOK=$(find "$BOOKS_DIR" -type f \( -iname "*.pdf" -o -iname "*.epub" -o -iname "*.djvu" \) | wofi --dmenu --prompt "Select a book" --width 1200 --height 400)

    if [[ -n "$BOOK" ]]; then
        zathura "$BOOK" &
    else
        echo "No book selected."
    fi
  '';

  windowSwitcher = pkgsStable.writeScriptBin "window-switcher" ''
    #!/bin/sh
    windows=$(hyprctl clients -j | jq -r '.[] | "\(.workspace.id):\(.workspace.name) - \(.class) - \(.title)"')
    selected=$(echo "$windows" | wofi --dmenu --prompt "Switch to window" --width 800)

    if [[ -n "$selected" ]]; then
      address=$(hyprctl clients -j | jq -r --arg sel "$selected" '.[] | select("\(.workspace.id):\(.workspace.name) - \(.class) - \(.title)" == $sel) | .address')
      hyprctl dispatch focuswindow "address:$address"
    fi
  '';
in
{
  home.packages = [
    booksScript
    windowSwitcher
  ];

  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mainMod, W, exec, ${windowSwitcher}/bin/window-switcher"
      # Window focus cycling with Tab
      "$mainMod, Tab, cyclenext,"
      "$mainMod SHIFT, Tab, cyclenext, prev"

      # Better window resizing with submap
      # "$mainMod, R, submap, resize"

      # Center floating window
      "$mainMod, C, centerwindow,"

      # Toggle window opacity
      "$mainMod, O, exec, hyprctl keyword decoration:active_opacity 0.8"
      "$mainMod SHIFT, O, exec, hyprctl keyword decoration:active_opacity 1.0"

      # Quick window swap
      "$mainMod, S, swapnext,"
      "$mainMod SHIFT, S, swapnext, prev"

      # Master layout specific
      "$mainMod, comma, layoutmsg, swapwithmaster"
      "$mainMod, period, layoutmsg, focusmaster"
      "$mainMod SHIFT, comma, layoutmsg, addmaster"
      "$mainMod SHIFT, period, layoutmsg, removemaster"

      # Quick actions
      "$mainMod, U, exec, hyprctl dispatch workspace previous" # Quick workspace switch
      "$mainMod, Z, exec, pypr zoom" # Zoom current window (needs pyprland)

      # Window groups
      "$mainMod, G, togglegroup,"
      "$mainMod SHIFT, G, moveoutofgroup,"

      # Special workspace for quick notes
      # "$mainMod, N, togglespecialworkspace, notes"
      # "$mainMod SHIFT, N, movetoworkspace, special:notes"

      # Color picker with notification
      "$mainMod, P, exec, hyprpicker -a && notify-send 'Color copied'"

      # Exit, lock
      "$mainMod SHIFT, Escape, exit,"
      "$mainMod,       Home, exec, loginctl lock-session"

      # Terminal
      "$mainMod,       Return, exec, $terminal"
      "$mainMod,       T, exec, $terminal --class=scratchpad"

      # Window management
      "$mainMod,       Q, killactive,"
      "$mainMod SHIFT, R, exec, $fileManager"
      "$mainMod,       R, exec, env -u TMUX alacritty -e yazi"
      "$mainMod,       F, togglefloating,"
      "$mainMod,       D, exec, $menu --show drun"
      "$mainMod,       J, togglesplit,"
      "$mainMod,       V, exec, cliphist list | $menu --dmenu | cliphist decode | wl-copy"
      "$mainMod,       M, fullscreen,"

      # Apps
      "$mainMod,       B, exec, brave"

      # Utilities
      "$mainMod,       E, exec, bemoji -cn"
      "$mainMod,       N, exec, swaync-client -t"

      # Waybar
      "$mainMod,       K, exec, pkill -SIGUSR2 waybar"
      "$mainMod SHIFT, K, exec, pkill -SIGUSR1 waybar"
      # "$mainMod,       W, exec, ${booksScript}/bin/open_books"

      # Screenshot
      ", Print, exec, hyprshot -zm region --clipboard-only"

      # Volume control
      "$mainMod, equal,  exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      "$mainMod, minus, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

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

      # Moving windows to workspaces
      "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
      "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
      "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
      "$mainMod SHIFT, 4, movetoworkspacesilent, 4"

      # Scratchpad
      "$mainMod,       X, togglespecialworkspace,  magic"
      "$mainMod SHIFT, X, movetoworkspace, special:magic"
    ];

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    # Laptop multimedia keys for volume and LCD brightness
    bindel = [
      ",XF86AudioRaiseVolume,  exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute,      exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      "$mainMod, bracketright, exec, brightnessctl s 10%+"
      "$mainMod, bracketleft,  exec, brightnessctl s 10%-"
    ];

    # Audio playback
    bindl = [
      ", XF86AudioNext,  exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay,  exec, playerctl play-pause"
      ", XF86AudioPrev,  exec, playerctl previous"
    ];
  };
}
