# Cava audio visualizer configuration.

{
  programs.cava = {
    enable = true;

    settings = {
      general = {
        framerate = 60;
        sensitivity = 80;
        autosens = 1;
      };

      color = {
        gradient = 1;
        gradient_color_1 = "'#ebdbb2'"; # foreground
        gradient_color_2 = "'#d65d0e'"; # orange
        gradient_color_3 = "'#fabd2f'"; # yellow
        gradient_color_4 = "'#8ec07c'"; # green
        gradient_color_5 = "'#83a598'"; # aqua
        gradient_color_6 = "'#d3869b'"; # purple
        gradient_color_7 = "'#fb4934'"; # red
        gradient_color_8 = "'#fe8019'"; # bright orange
      };
    };
  };
}
