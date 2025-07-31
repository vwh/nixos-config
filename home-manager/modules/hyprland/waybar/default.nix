# Waybar (status bar) configuration.

{
  programs.waybar = {
    enable = true;
    style = ./style.css;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];

        # modules-center = [  ];

        modules-right = [
          "cpu"
          "memory"
          "disk"
          # "hyprland/language"
          "pulseaudio"
          "custom/weather"
          "custom/prayerbar"
          "custom/network"
          "battery"
          "clock"
          "tray"
        ];

        "cpu" = {
          format = "  {usage}%";
          tooltip = false;
        };

        "memory" = {
          format = " {percentage}%";
          tooltip = false;
        };

        "disk" = {
          path = "/";
          format = "  {percentage_used}%";
          tooltip = false;
        };

        "hyprland/window" = {
          max-length = 50;
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          show-special = true;
          special-visible-only = true;
          all-outputs = false;
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "magic" = "10";
          };

          persistent-workspaces = {
            "*" = 5;
          };
        };

        # "hyprland/language" = {
        #   format-en = "en";
        #   format-ar = "ar";
        #   min-length = 5;
        #   tooltip = false;
        # };

        "custom/weather" = {
          format = " {} ";
          exec = "curl -s 'wttr.in/amman?format=%c%t'";
          interval = 500;
          class = "weather";
        };

        "pulseaudio" = {
          format = "{icon}  {volume}%";
          format-bluetooth = "{icon}  {volume}% ";
          format-muted = "";

          format-icons = {
            "headphones" = "";
            "handsfree" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [
              ""
              ""
            ];
          };

          on-click = "pavucontrol";
        };

        "custom/network" = {
          interval = 1;
          exec = "~/System/scripts/waybar/network.sh";
          format = "  {}";
          on-click = "nm-connection-editor";
        };

        "custom/prayerbar" = {
          format = "{}";
          tooltip = true;
          interval = 60;
          exec = "~/System/scripts/waybar/prayerbar-wrapper.sh";
          "return-type" = "json";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 1;
          };

          format = "{icon}  {capacity}%";
          format-charging = "  {capacity}%";
          format-alt = "{time}  {icon}";

          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "clock" = {
          format = "{:%d.%m - %I:%M %p}";
          format-alt = "{:%A, %B %d at %I:%M %p}";
        };

        "tray" = {
          icon-size = 14;
          spacing = 1;
        };
      };
    };
  };
}
