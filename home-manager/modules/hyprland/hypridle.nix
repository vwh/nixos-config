# Hypridle (idle management) configuration.

{
  services.hypridle = {
    enable = true;

    settings = {

      general = {
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || hyprlock";
      };

      listener = [
        {
          timeout = 180;
          on-timeout = "brightnessctl -s set 30";
          on-resume = "brightnessctl -r";
        }

        {
          timeout = 500;
          on-timeout = "loginctl lock-session";
        }

        {
          timeout = 1400;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }

        {
          timeout = 2200;
          on-timeout = "sysemctl suspend";
        }
      ];
    };
  };
}
