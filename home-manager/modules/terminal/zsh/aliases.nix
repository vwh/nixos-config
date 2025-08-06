# Zsh shell aliases.

{
  programs.zsh.shellAliases =
    let
      editor = "code";
      nixTemplates = "github:vwh/nixos-config/main?dir=devShells#";
    in
    {
      # navigation
      ls = "eza --icons --group-directories-first";
      ll = "eza -l --icons --group-directories-first --header";
      la = "eza -la --icons --group-directories-first --header";
      lt = "eza --tree --level=2 --icons";
      etree = "eza --tree --level=1 --icons";
      cd = "z";
      ci = "zi";

      # Quick navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";

      # Directory shortcuts
      dl = "cd ~/Downloads";
      dt = "cd ~/Desktop";
      docs = "cd ~/Documents";
      proj = "cd ~/Projects";

      # Enhanced search and text processing
      find = "fd";
      grep = "rg";
      hq = "htmlq";
      cat = "bat --style=auto";
      less = "bat --style=auto --paging=always";

      # Advanced search
      rgi = "rg -i"; # case insensitive
      rgf = "rg --files-with-matches"; # only show filenames
      rgc = "rg --count"; # count matches

      # Code info
      tk = "tokei";
      tf = "tokei --files";

      # Files
      fs = "fselect";

      # Editors
      v = "${editor}";
      se = "sudoedit";

      # System info
      ff = "fastfetch";
      mf = "microfetch";
      of = "onefetch";

      # General tools
      lg = "lazygit";
      ld = "lazydocker";

      # AI tools
      gemi = "gemini";
      open = "opencode";

      # Nix tools
      ns = "nix-shell";
      nd = "nix develop --command zsh";
      nfu = "nix flake update";
      nfs = "nix flake show";
      nfi = "nix flake init";
      nfib = "nfi -t '${nixTemplates}bun'";
      nfid = "nfi -t '${nixTemplates}deno'";
      nfin = "nfi -t '${nixTemplates}nodejs'";
      nfip = "nfi -t '${nixTemplates}python-venv'";
      nfirs = "nfi -t '${nixTemplates}rust-stable'";
      nfirn = "nfi -t '${nixTemplates}rust-nightly'";

      # System management
      docker = "sudo docker";
      reboot = "sudo reboot";
      shutdown = "sudo shutdown now";

      # Process management
      psg = "ps aux | grep";
      killall = "pkill -f";

      # Network utilities
      ports = "lsof -i -P -n | grep LISTEN";
      myip = "curl -s https://ipinfo.io/ip";
      localip = "ip route get 1.1.1.1 | awk '{print $7}'";

      # Disk usage
      du1 = "du -h --max-depth=1";
      ducks = "du -cks * | sort -rn | head";

      # Docker shortcuts (enhanced)
      d = "docker";
      dc = "docker-compose";
      dps = "docker ps --format 'table {{.Names}}\\t{{.Status}}\\t{{.Ports}}'";
      dpa = "docker ps -a --format 'table {{.Names}}\\t{{.Status}}\\t{{.Ports}}'";
      di = "docker images --format 'table {{.Repository}}\\t{{.Tag}}\\t{{.Size}}'";
      dex = "docker exec -it";
      dlogs = "docker logs -f";
    };
}
