# Sway Notification Center configuration.

{ lib, ... }:

{
  services.swaync = {
    enable = true;

    # Flat Gruvbox style (matches your Waybar). No blur.
    style = lib.mkForce ''
      * {
        font-family: "JetBrains Mono", monospace;
        font-weight: 600;
        font-size: 14px;
        color: #ebdbb2;
      }

      /* Control Center container */
      .control-center {
        background: #1d2021;
        border: 2px solid #3c3836;
        border-radius: 0;
        padding: 8px;
        margin: 8px;
        box-shadow: none;
      }

      /* Title row */
      .cc-header,
      .widget-title {
        background: rgba(40, 40, 40, 0.35);
        border-bottom: 1px solid rgba(60, 56, 54, 0.6);
        padding: 8px 12px;
        margin: 0 0 8px 0;
      }
      .widget-title > label {
        color: #ebdbb2;
      }
      .widget-title > button,
      .clear-all {
        background: rgba(40, 40, 40, 0.6);
        color: #ebdbb2;
        border: 1px solid #3c3836;
        border-radius: 0;
        padding: 4px 8px;
      }
      .widget-title > button:hover,
      .clear-all:hover {
        background: rgba(40, 40, 40, 0.8);
      }

      /* Widgets */
      .widget,
      .widget-dnd,
      .widget-inhibitors,
      .widget-mpris,
      .widget-volume,
      .widget-backlight {
        background: rgba(40, 40, 40, 0.35);
        border: 1px solid rgba(60, 56, 54, 0.6);
        border-radius: 0;
        margin: 0 0 8px 0;
        padding: 8px 12px;
      }
      .widget:last-child { margin-bottom: 0; }
      .widget:hover {
        background: rgba(40, 40, 40, 0.5);
      }

      /* DND switch */
      .widget-dnd switch {
        background: rgba(60, 56, 54, 0.8);
        border-radius: 0;
        border: 1px solid #3c3836;
      }
      .widget-dnd switch:checked {
        background: #d65d0e;
        border-color: #d65d0e;
      }
      .widget-dnd switch slider {
        background: #ebdbb2;
        border: 1px solid #3c3836;
        border-radius: 0;
      }

      /* Notifications list wrapper */
      .notifications {
        padding: 0;
        margin: 0;
      }

      /* Space between cards */
      .notification-row {
        margin: 0 0 10px 0;
        padding: 0;
        background: transparent;
        border: none;
      }
      .notification-row:last-child { margin-bottom: 0; }

      /* Card */
      .notification {
        background: #282828;
        border: 2px solid #3c3836;
        border-radius: 0;
        padding: 8px 10px;
        margin: 0;
        box-shadow: none;
      }

      /* Remove theme inner bubbles */
      .notification .content,
      .notification .text-box,
      .notification .widget-title {
        background: transparent;
        border: none;
        border-radius: 0;
        box-shadow: none;
        padding: 0;
        margin: 0;
      }

      /* Header text + time */
      .notification .summary { color: #ebdbb2; margin-right: 8px; }
      .notification .time { color: #a89984; }

      /* Body */
      .notification .body { color: #a89984; }

      /* App icon / image */
      .notification .image,
      .notification .icon {
        margin-right: 8px;
        border-radius: 0;
      }

      /* Close button */
      .notification .close-button {
        background: #cc241d;
        color: #1d2021;
        border: 1px solid #cc241d;
        border-radius: 0;
        padding: 2px 6px;
        margin: 0;
      }
      .notification .close-button:hover {
        background: #fb4934;
        border-color: #fb4934;
      }

      /* Actions */
      .notification .actions { margin-top: 8px; }
      .notification .action-button {
        background: rgba(40, 40, 40, 0.5);
        border: 1px solid #3c3836;
        border-radius: 0;
        padding: 4px 8px;
        color: #ebdbb2;
      }
      .notification .action-button:hover {
        background: rgba(40, 40, 40, 0.7);
      }

      /* Severity accents (subtle) */
      .notification.low    { border-left: 3px solid #98971a; }
      .notification.normal { border-left: 3px solid #458588; }
      .notification.critical {
        border-left: 3px solid #cc241d;
        background: rgba(204, 36, 29, 0.10);
      }

      /* Progress bars */
      .progress {
        background: #3c3836;
        border-radius: 0;
        height: 6px;
        margin-top: 6px;
      }
      .progress .fill {
        background: #d65d0e;
        border-radius: 0;
      }

      /* MPRIS */
      .mpris,
      .widget-mpris-player {
        background: rgba(40, 40, 40, 0.5);
        border: 1px solid #3c3836;
        border-radius: 0;
        padding: 8px;
      }
      .mpris .title { color: #ebdbb2; }
      .mpris .artist { color: #a89984; }
      .widget-mpris > button {
        background: rgba(60, 56, 54, 0.6);
        color: #ebdbb2;
        border: 1px solid #3c3836;
        border-radius: 0;
        padding: 6px;
        margin: 2px;
      }
      .widget-mpris > button:hover {
        background: #d65d0e;
        color: #1d2021;
        border-color: #d65d0e;
      }

      /* Sliders */
      .widget-volume scale trough,
      .widget-backlight scale trough {
        background: rgba(60, 56, 54, 0.8);
        border-radius: 0;
        min-height: 4px;
      }
      .widget-volume scale highlight,
      .widget-backlight scale highlight {
        background: #fabd2f;
        border-radius: 0;
      }
      .widget-volume scale slider,
      .widget-backlight scale slider {
        background: #ebdbb2;
        border: 1px solid #3c3836;
        border-radius: 0;
        min-width: 12px;
        min-height: 12px;
      }

      /* Scrollbar */
      scrollbar {
        background: rgba(60, 56, 54, 0.30);
        border-radius: 0;
        width: 4px;
      }
      scrollbar slider {
        background: rgba(168, 153, 132, 0.6);
        border-radius: 0;
      }
      scrollbar slider:hover {
        background: rgba(168, 153, 132, 0.8);
      }

      /* Hard overrides */
      .control-center, .notification, .widget, .mpris,
      .notification .close-button, .action-button,
      .progress, .progress .fill {
        border-radius: 0 !important;
        box-shadow: none !important;
        outline: none !important;
      }
    '';

    settings = {
      # Position/layout
      positionX = "right";
      positionY = "top";
      control-center-margin-top = 8;
      control-center-margin-bottom = 8;
      control-center-margin-right = 8;
      control-center-margin-left = 8;
      control-center-width = 380;
      control-center-height = 600;
      control-center-radius = 0;

      fit-to-screen = false;
      layer-shell = true;
      layer = "overlay";
      control-center-layer = "overlay";
      cssPriority = "user";

      # Notifications
      notification-icon-size = 48;
      notification-body-image-height = 80;
      notification-body-image-width = 160;
      notification-window-width = 380;
      notification-2fa-action = true;

      # Timeouts
      timeout = 8;
      timeout-low = 4;
      timeout-critical = 0;

      hide-on-clear = false;
      hide-on-action = true;
      script-fail-notify = true;

      widgets = [
        "title"
        "dnd"
        "inhibitors"
        "mpris"
        "volume"
        "backlight"
        "notifications"
      ];

      widget-config = {
        title = {
          text = "Control Center";
          clear-all-button = true;
          button-text = "Clear All";
        };

        dnd = {
          text = "󰂛 Do Not Disturb";
        };

        inhibitors = {
          text = "Inhibitors";
          clear-all-button = true;
          button-text = "Clear All";
        };

        mpris = {
          image-size = 80;
          image-radius = 0;
          blur = false;
        };

        volume = {
          label = "󰕾";
          show-per-app = true;
        };

        backlight = {
          label = "󰃞";
          device = "intel_backlight";
        };
      };

      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 150;
    };
  };
}
