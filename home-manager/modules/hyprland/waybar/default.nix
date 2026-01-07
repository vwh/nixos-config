# Waybar (status bar) configuration.

{
  # Enable Waybar status bar
  programs.waybar = {
    enable = true;
    style = ./style.css; # External CSS styling file

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 27;

        # Performance settings
        gtk-layer-shell = true;
        spacing = 2;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];

        # modules-center = [  ];

        modules-right = [
          # "custom/uptime"
          # "custom/media"
          "cpu"
          "custom/cpu-temp"
          "custom/gpu-usage"
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
          tooltip-format = "CPU Usage: {usage}%";
          interval = 5;
          states = {
            warning = 70;
            critical = 90;
          };
        };

        "custom/gpu-temp" = {
          format = " {}";
          exec = "~/System/scripts/waybar/gpu-temp.sh";
          interval = 15;
          tooltip = true;
          tooltip-format = "GPU Temperature: {}";
        };

        "custom/gpu-usage" = {
          format = "󰍹 {}%";
          exec = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits || echo 'N/A'";
          interval = 30;
          class = "gpu-usage";
          tooltip = true;
          tooltip-format = "GPU Usage: {}%";
        };

        "custom/cpu-temp" = {
          format = " {}°C";
          exec = "cat /sys/class/hwmon/hwmon*/temp*_input 2>/dev/null | head -n1 | awk '{printf \"%.0f\", $1/1000}' || echo 'N/A'";
          interval = 10;
          tooltip = true;
          tooltip-format = "CPU Temperature: {}°C";
        };

        "memory" = {
          format = " {percentage}%";
          tooltip-format = "Memory: {used:0.1f}G/{total:0.1f}G ({percentage}%)\nAvailable: {avail:0.1f}G";
          interval = 5;
          states = {
            warning = 80;
            critical = 95;
          };
        };

        "disk" = {
          path = "/";
          format = " {percentage_used}%";
          tooltip-format = "Disk Usage: {used}/{total} ({percentage_used}%)";
          interval = 60;
          states = {
            warning = 80;
            critical = 95;
          };
        };

        "hyprland/window" = {
          max-length = 50;
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
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          tooltip-format = "Volume: {volume}%\nDevice: {desc}";
        };

        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          on-click = "pavucontrol -t 4";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-";
          tooltip-format = "Mic: {volume}%\nDevice: {desc}";
        };

        "custom/prayerbar" = {
          format = "{}";
          tooltip = true;
          interval = 1000;
          exec = "prayerbar --city Amman --country JO --method 4 --ampm";
          "return-type" = "json";
        };

        "custom/network" = {
          interval = 60;
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
        };

        clock = {
          format = "{:%I:%M %p}";
          format-alt = " {:%A, %B %d at %I:%M %p}";
          tooltip-format = "<big>{:%A, %B %d, %Y}</big>\n<small>{:%I:%M %p}</small>";
          on-click = "gnome-calendar";
        };

        "tray" = {
          icon-size = 12;
          spacing = 6;
          show-passive-items = true;
        };

        # "custom/uptime" = {
        #   format = " {}";
        #   exec = "uptime -p | sed 's/up //'";
        #   interval = 60;
        # };

        # "custom/media" = {
        #   format = "{icon} {}";
        #   format-icons = {
        #     "Playing" = "";
        #     "Paused" = "";
        #   };
        #   exec = "playerctl metadata --format '{{ status }}: {{ artist }} - {{ title }}'";
        #   interval = 1;
        #   on-click = "playerctl play-pause";
        #   on-scroll-up = "playerctl next";
        #   on-scroll-down = "playerctl previous";
        # };
      };
    };
  };
}
