# Waybar (status bar) configuration.

{
  programs.waybar = {
    enable = true;
    style = ./style.css;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 27;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];

        # modules-center = [  ];

        modules-right = [
          "cpu"
          "custom/cpu-temp"
          "custom/gpu-temp"
          "memory"
          "disk"
          # "hyprland/language"
          "pulseaudio"
          "pulseaudio#microphone"
          # "custom/weather"
          "custom/prayerbar"
          "custom/network"
          "battery"
          "clock"
          "tray"
        ];

        "cpu" = {
          format = "  {usage}%";
          tooltip-format = "CPU Usage: {usage}%
Load: {load}";
          interval = 2;
          states = {
            warning = 70;
            critical = 90;
          };
        };

        "custom/gpu-temp" = {
          format = " {}°C";
          exec = "~/System/scripts/waybar/gpu-temp.sh";
          interval = 5;
          tooltip = true;
          tooltip-format = "GPU Temperature: {}°C";
        };

        "custom/cpu-temp" = {
          format = " {}°C";
          exec = "sensors | grep 'Package id 0:' | awk '{print $4}' | sed 's/+//;s/°C.*//' || sensors | grep 'Tctl:' | awk '{print $2}' | sed 's/+//;s/°C.*//' || echo 'N/A'";
          interval = 5;
          tooltip = true;
          tooltip-format = "CPU Temperature: {}°C";
        };

        "memory" = {
          format = " {percentage}%";
          tooltip-format = "Memory: {used:0.1f}G/{total:0.1f}G ({percentage}%)\nAvailable: {avail:0.1f}G";
          interval = 2;
          states = {
            warning = 80;
            critical = 95;
          };
        };

        "disk" = {
          path = "/";
          format = " {percentage_used}%";
          tooltip-format = "Disk Usage: {used}/{total} ({percentage_used}%)";
          interval = 30;
          states = {
            warning = 80;
            critical = 95;
          };
        };

        "hyprland/window" = {
          max-length = 35;
          separate-outputs = true;
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
            "magic" = "";
          };

          persistent-workspaces = {
            "*" = 4;
          };
        };

        # "hyprland/language" = {
        #   format-en = " EN";
        #   format-ar = " AR";
        #   min-length = 5;
        #   tooltip = false;
        # };

        # "custom/weather" = {
        #   format = "{} ";
        #   exec = "curl -s 'wttr.in/amman?format=1' | sed 's/^[[:space:]]*//'";
        #   interval = 600;
        #   class = "weather";
        #   tooltip-format = "Weather in Amman";
        # };

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

          scroll-step = 5;
          on-click = "pavucontrol";
          on-click-right = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
          on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
          tooltip-format = "Volume: {volume}%\nDevice: {desc}";
        };

        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          on-click = "pavucontrol -t 4";
          on-click-right = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          on-scroll-up = "pactl set-source-volume @DEFAULT_SOURCE@ +5%";
          on-scroll-down = "pactl set-source-volume @DEFAULT_SOURCE@ -5%";
          tooltip-format = "Mic: {volume}%\nDevice: {desc}";
        };

        "custom/prayerbar" = {
          format = "{}";
          tooltip = true;
          interval = 600;
          exec = "prayerbar --city Amman --country JO --method 4 --ampm";
          "return-type" = "json";
        };

        "custom/network" = {
          interval = 30;
          exec = "~/System/scripts/waybar/network.sh";
          format = "  {}";
          on-click = "nm-connection-editor";
          tooltip = true;
        };

        "battery" = {
          states = {
            good = 80;
            warning = 30;
            critical = 15;
          };

          format = "{icon}  {capacity}%";
          format-charging = "  {capacity}%";
          format-plugged = "  {capacity}%";
          format-alt = "{time}  {icon}";
          format-full = "  {capacity}%";

          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];

          tooltip-format = "Battery: {capacity}%\nTime: {time}\nPower: {power}W";
          on-click = "gnome-power-statistics";
        };

        "clock" = {
          format = "{:%H:%M}";
          format-alt = " {:%A, %B %d at %I:%M %p}";
          tooltip-format = "<big>{:%A, %B %d, %Y}</big>\n<small>{:%I:%M %p}</small>";
          on-click = "gnome-calendar";
        };

        "tray" = {
          icon-size = 15;
          spacing = 6;
          show-passive-items = true;
        };
      };
    };
  };
}
