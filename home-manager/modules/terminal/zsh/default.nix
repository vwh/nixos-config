# Z-shell (Oh My Zsh) configuration.

{ config, ... }:

{
  imports = [
    ./aliases.nix
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    oh-my-zsh = {
      enable = true;
      custom = builtins.toString ./custom_omz_dir;
      theme = "oxide";

      plugins = [
        "git"
        "sudo"
      ];
    };

    initContent = ''
      # Start Tmux automatically if not already running. No Tmux in TTY
      if [ -z "$TMUX" ] && [ -n "$DISPLAY" ]; then
        tmux attach-session -t default || tmux new-session -s default
      fi

      # Start UWSM
      if uwsm check may-start > /dev/null && uwsm select; then
        exec systemd-cat -t uwsm_start uwsm start default
      fi
    '';
  };
}
