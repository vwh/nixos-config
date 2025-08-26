# Git version control configuration.
# This module configures Git with user settings, GPG signing, global ignores,
# and useful aliases for efficient development workflow.

{ gitConfig, ... }:

{
  programs.git = {
    enable = true;

    userName = gitConfig.name;
    userEmail = gitConfig.email;
    signing = {
      key = gitConfig.gitKey;
      signByDefault = true;
    };

    ignores = [
      ".cache/"
      ".DS_Store"
      ".idea/"
      "*.swp"
      "*.elc"
      "auto-save-list"
      ".direnv/"
      "node_modules"
      "result"
      "result-*"
    ];

    # Git command aliases for improved productivity
    aliases = {
      # Status and Logs - Quick repository overview
      st = "status"; # Show working tree status
      co = "checkout"; # Switch branches or restore files
      br = "branch"; # List, create, or delete branches
      lg = "log --oneline --graph --decorate"; # Compact log with graph
      lga = "log --oneline --graph --decorate --all"; # Log all branches

      # Add, Commit, Push, Pull - Core workflow commands
      ad = "add"; # Stage files for commit
      cm = "commit -m"; # Commit with message
      amend = "commit --amend --no-edit"; # Fix last commit without changing message
      pl = "pull"; # Fetch and merge changes
      ps = "push"; # Push local commits

      # Diff and Restore - File change management
      df = "diff"; # Show unstaged changes
      dft = "diff --cached"; # Show staged changes
      rs = "restore"; # Restore working tree files
      rst = "restore --staged"; # Unstage files

      # Reset and Rebase - History manipulation
      rb = "rebase"; # Rebase current branch
      rbi = "rebase -i"; # Interactive rebase
      rset = "reset"; # Reset current HEAD
      rseth = "reset --hard"; # Hard reset (destructive)

      # Tags - Version tagging
      tg = "tag"; # List or create tags
      tga = "tag -a"; # Create annotated tag

      # Clean - Repository maintenance
      cl = "clean -fd"; # Remove untracked files and directories

      # Submodules - Nested repository management
      sm = "submodule"; # Submodule commands
      smu = "submodule update --init --recursive"; # Update all submodules

      # Remote - Repository connection management
      rmt = "remote"; # Remote repository commands
      rmtv = "remote -v"; # Show remote URLs

      # Cherry-pick and Stash - Advanced operations
      cp = "cherry-pick"; # Apply specific commits
      stsh = "stash"; # Stash working changes
      stshl = "stash list"; # List stashed changes
      stsha = "stash apply"; # Apply stashed changes
      stshd = "stash drop"; # Remove stashed changes

      # Git Config - Configuration inspection
      cfg = "config --list"; # Show all config
      cfgg = "config --global --list"; # Show global config

      # Git Ignore - Ignore pattern debugging
      ign = "!git check-ignore -v"; # Check why files are ignored
    };
  };
}
