{
  programs.ranger = {
    enable = true;
    mappings = {
      e = "edit";

      ec = "compress";
      ex = "extract";

      b = "fzm";
    };

    settings = {
      preview_images = true;
      preview_images_method = "ueberzug";
      draw_borders = true;
      w3m_delay = 0;
    };

    extraConfig = ''
      default_linemode devicons2
    '';

    plugins = [
      {
        name = "ranger-archives";
        src = builtins.fetchGit {
          url = "https://github.com/maximtrp/ranger-archives";
          ref = "master";
          rev = "b4e136b24fdca7670e0c6105fb496e5df356ef25";
        };
      }
      {
        name = "ranger-devicons2";
        src = builtins.fetchGit {
          url = "https://github.com/cdump/ranger-devicons2";
          ref = "master";
          rev = "94bdcc19218681debb252475fd9d11cfd274d9b1";
        };
      }
      {
        name = "ranger_tmux";
        src = builtins.fetchGit {
          url = "https://github.com/joouha/ranger_tmux";
          ref = "master";
          rev = "05ba5ddf2ce5659a90aa0ada70eb1078470d972a";
        };
      }
    ];
  };

  home.file.".config/ranger/commands.py".text = "from plugins.ranger_udisk_menu.mounter import mount";
}
