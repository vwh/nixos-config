# Eza (ls replacement) configuration.

{
  programs.eza = {
    enable = true; # Enable eza as ls replacement
    enableZshIntegration = true; # Enable Zsh shell integration
    colors = "always"; # Always use colors for output
    git = true; # Show git status indicators
    icons = "always"; # Always show file type icons

    # Additional command-line options
    extraOptions = [
      "--group-directories-first" # List directories before files
      "--header" # Show header with column names
    ];
  };
}
