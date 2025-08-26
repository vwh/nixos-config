# Htop (interactive process viewer) configuration.
# This module configures htop, an interactive process viewer with
# enhanced features for monitoring system processes and resources.

{
  programs.htop = {
    enable = true; # Enable htop for process monitoring

    settings = {
      tree_view = 1; # Enable tree view to show process hierarchy
    };
  };
}
