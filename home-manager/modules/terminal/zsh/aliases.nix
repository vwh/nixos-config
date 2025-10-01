# Zsh shell aliases.
# This module defines custom shell aliases for enhanced productivity,
# navigation, development workflows, and system administration.

{
  programs.zsh.shellAliases =
    let
      editor = "code"; # Default editor for file operations
      nixTemplates = "github:vwh/nixos-config/main?dir=devShells#"; # Nix flake templates
    in
    {
      # Enhanced navigation aliases using modern tools
      ls = "eza --icons --group-directories-first"; # Enhanced ls with icons
      ll = "eza -l --icons --group-directories-first --header"; # Long listing with headers
      la = "eza -la --icons --group-directories-first --header"; # All files with details
      lt = "eza --tree --level=2 --icons"; # Tree view (2 levels)
      etree = "eza --tree --level=1 --icons"; # Extended tree view
      cd = "z"; # Smart directory jumping
      ci = "zi"; # Interactive directory selection

      # Quick navigation shortcuts for moving up directory tree
      ".." = "cd .."; # Go up one directory
      "..." = "cd ../.."; # Go up two directories
      "...." = "cd ../../.."; # Go up three directories
      "....." = "cd ../../../.."; # Go up four directories

      # Common directory shortcuts for quick navigation
      dl = "cd ~/Downloads"; # Downloads directory
      dt = "cd ~/Desktop"; # Desktop directory
      docs = "cd ~/Documents"; # Documents directory
      proj = "cd ~/Projects"; # Projects directory

      # Enhanced search and text processing tools
      find = "fd"; # Modern find replacement
      grep = "rg"; # Modern grep replacement
      hq = "htmlq"; # HTML query tool
      cat = "bat --style=auto"; # Enhanced cat with syntax highlighting
      less = "bat --style=auto --paging=always"; # Enhanced pager

      # Advanced search aliases with specific options
      rgi = "rg -i"; # Case-insensitive search
      rgf = "rg --files-with-matches"; # Show only filenames with matches
      rgc = "rg --count"; # Count matches per file

      # Code analysis and statistics
      tk = "tokei"; # Code statistics tool
      tf = "tokei --files"; # Code statistics with file details

      # File selection and management
      fs = "fselect"; # SQL-like file selection

      # Editor shortcuts
      v = "${editor}"; # Open file in default editor
      se = "sudoedit"; # Edit files with sudo privileges

      # System information and monitoring tools
      ff = "fastfetch"; # System information display
      mf = "microfetch"; # Minimal system info
      of = "onefetch"; # Git repository information

      # Development and productivity tools
      lg = "lazygit"; # Terminal Git UI
      ld = "lazydocker"; # Terminal Docker UI

      # AI and coding assistance tools
      cl = "claude"; # Anthropic Claude CLI
      gm = "gemini"; # Google Gemini AI
      oc = "opencode"; # OpenCode AI
      "ac" = "ai-commit"; # Generate conventional commit messages
      "ak" = "ai-ask"; # Ask AI questions
      "ah" = "ai-help"; # Get command suggestions

      # Nix ecosystem tools and shortcuts
      ns = "nix-shell"; # Start Nix shell
      nd = "nix develop --command zsh"; # Enter development environment
      nfu = "nix flake update"; # Update flake dependencies
      nfs = "nix flake show"; # Show flake outputs
      nfi = "nix flake init"; # Initialize new flake

      # Development environment templates
      nfib = "nfi -t '${nixTemplates}bun'"; # Bun.js template
      nfid = "nfi -t '${nixTemplates}deno'"; # Deno template
      nfin = "nfi -t '${nixTemplates}nodejs'"; # Node.js template
      nfip = "nfi -t '${nixTemplates}python-venv'"; # Python template
      nfirs = "nfi -t '${nixTemplates}rust-stable'"; # Rust stable template
      nfirn = "nfi -t '${nixTemplates}rust-nightly'"; # Rust nightly template

      # System administration shortcuts
      docker = "sudo docker"; # Docker with sudo
      reboot = "sudo reboot"; # System reboot
      shutdown = "sudo shutdown now"; # System shutdown

      # Process management utilities
      psg = "ps aux | grep"; # Search running processes
      killall = "pkill -f"; # Kill processes by pattern

      # Network diagnostic tools
      ports = "lsof -i -P -n | grep LISTEN"; # Show listening ports
      myip = "curl -s https://ipinfo.io/ip"; # Get public IP
      localip = "ip route get 1.1.1.1 | awk '{print $7}'"; # Get local IP

      # Disk usage analysis tools
      du1 = "du -h --max-depth=1"; # Directory sizes (1 level)
      ducks = "du -cks * | sort -rn | head"; # Largest directories

      # Docker container management shortcuts
      d = "docker"; # Docker command
      dc = "docker-compose"; # Docker Compose
      dps = "docker ps --format 'table {{.Names}}\\t{{.Status}}\\t{{.Ports}}'"; # Running containers
      dpa = "docker ps -a --format 'table {{.Names}}\\t{{.Status}}\\t{{.Ports}}'"; # All containers
      di = "docker images --format 'table {{.Repository}}\\t{{.Tag}}\\t{{.Size}}'"; # Docker images
      dex = "docker exec -it"; # Execute into container
      dlogs = "docker logs -f"; # Follow container logs

      j = "just"; # Justfile runner
    };
}
