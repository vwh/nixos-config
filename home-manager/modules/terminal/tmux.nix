{ pkgsStable, ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    mouse = true;
    escapeTime = 0;
    keyMode = "vi";
    terminal = "tmux-256color";

    extraConfig = ''
      set -as terminal-features ",alacritty*:RGB"

      # Make status bar stick to bottom and handle resizing properly
      set -g status-position bottom
      set -g aggressive-resize on
      set -g automatic-rename on
      set -g renumber-windows on

      # Better window resizing handling
      setw -g aggressive-resize on

      bind -n M-r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
      bind C-p previous-window
      bind C-n next-window

      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9

      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      bind -n M-S-Left resize-pane -L 5
      bind -n M-S-Right resize-pane -R 5
      bind -n M-S-Up resize-pane -U 3
      bind -n M-S-Down resize-pane -D 3

      bind -n M-s split-window -v
      bind -n M-v split-window -h

      bind -n M-o new-window -c ~/para "nvim -c 'Telescope find_files' '0 Inbox/todolist.md'"
      bind -n M-f new-window -c ~/flake "nvim -c 'Telescope find_files' flake.nix"
      bind -n M-n new-window -c ~/.config/nvim "nvim -c 'Telescope find_files' init.lua"
      bind -n M-Enter new-window
      bind -n M-c kill-pane
      bind -n M-q kill-window
      bind -n M-Q kill-session

      # Cool Gruvbox theme 
      set -g status-style "bg=#282828,fg=#ebdbb2"
      set -g status-left-length 40
      set -g status-right-length 60

      # Left side: Clean session name
      set -g status-left "#[bg=#fe8019,fg=#1d2021,bold] #S "

      # Right side: Git branch and current directory
      set -g status-right "#[bg=#458588,fg=#1d2021,bold] ⎇  #(cd #{pane_current_path}; git branch --show-current 2>/dev/null || echo 'no-git') │ 📁 #{b:pane_current_path} "

      # Window styling
      set -g window-status-format "#[bg=#3c3836,fg=#a89984] #I │ #W "
      set -g window-status-current-format "#[bg=#b8bb26,fg=#1d2021,bold] #I │ #W "
      set -g window-status-separator ""

      # Pane borders
      set -g pane-border-style "fg=#504945"
      set -g pane-active-border-style "fg=#fe8019,bold"

      # Message colors
      set -g message-style "bg=#fe8019,fg=#1d2021,bold"
      set -g message-command-style "bg=#b8bb26,fg=#1d2021,bold"

      # Clock color
      set -g clock-mode-colour "#b8bb26"
    '';

    plugins = with pkgsStable; [
      # No plugins needed
    ];
  };
}
