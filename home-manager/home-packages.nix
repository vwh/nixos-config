{ pkgs, pkgsStable, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [

    # ──────────────────────────────────────────────────────────────────────────
    # SSL / Crypto / Certificates
    # ──────────────────────────────────────────────────────────────────────────
    openssl                 # crypto library
    openssl.dev             # headers & static libs

    # ──────────────────────────────────────────────────────────────────────────
    # C / C++ Toolchain & Build Tools
    # ──────────────────────────────────────────────────────────────────────────
    gcc                      # C compiler
    gnumake                  # make
    cmake                    # CMake build system

    # ──────────────────────────────────────────────────────────────────────────
    # Shells & Core Utilities
    # ──────────────────────────────────────────────────────────────────────────
    zsh                      # Z-Shell
    coreutils                # ls, cp, mv, etc.
    findutils                # find, xargs
    diffutils                # diff, patch
    gzip                     # compression
    unzip                    # decompression

    # ──────────────────────────────────────────────────────────────────────────
    # Version Control & Networking
    # ──────────────────────────────────────────────────────────────────────────
    git                      # version control
    openssh                  # ssh client/server
    curl                     # HTTP client
    wget                     # HTTP client
    rsync                    # file sync
    dnsutils                 # dig, nslookup

    # ──────────────────────────────────────────────────────────────────────────
    # Common Dev Toolchains
    # ──────────────────────────────────────────────────────────────────────────
    openjdk23                # newer Java
    rustc                    # Rust compiler
    cargo                    # Rust package manager
    go                       # Go compiler & tooling
    sqlite                   # embedded DB + CLI
    nix-prefetch-scripts     # helper for nix

    # ──────────────────────────────────────────────────────────────────────────
    # Desktop Applications
    # ──────────────────────────────────────────────────────────────────────────
    audacity
    brave
    anki
    alacritty
    vscode
    obs-studio
    obsidian
    pavucontrol
    telegram-desktop
    tor-browser
    libreoffice-qt6-fresh
    sqlitebrowser
    teams-for-linux

    # ──────────────────────────────────────────────────────────────────────────
    # Multimedia & Imaging
    # ──────────────────────────────────────────────────────────────────────────
    mpv
    feh
    imv
    ffmpeg
    ffmpegthumbnailer
    playerctl
    ripgrep
    flameshot
    grimblast
    udisks
    ueberzugpp
    mediainfo
    yt-dlp

    # ──────────────────────────────────────────────────────────────────────────
    # CLI Utilities
    # ──────────────────────────────────────────────────────────────────────────
    tree
    file
    bc
    htop
    bottom
    neofetch
    fzf
    direnv
    cliphist
    wl-clipboard
    w3m
    zip
    brightnessctl
    showmethekey
    microfetch

    # ──────────────────────────────────────────────────────────────────────────
    # GUI Helpers & Launchers
    # ──────────────────────────────────────────────────────────────────────────
    rofi
    wofi
    dmenu
    screenkey
    gromit-mpx
    pipewire
    pulseaudio
    pamixer

    # ──────────────────────────────────────────────────────────────────────────
    # GNOME Extensions
    # ──────────────────────────────────────────────────────────────────────────
    gnomeExtensions.clipboard-history
    gnomeExtensions.dash-to-dock
  ];
}