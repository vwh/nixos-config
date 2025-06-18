{ pkgs, pkgsStable, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "python-2.7.18.8" "electron-25.9.0" ];
  };
  
  home.packages = with pkgs; [
    # Desktop apps
    audacity
    brave
    anki
    alacritty
    obs-studio
    rofi
    wofi
    imv
    mpv
    obs-studio
    obsidian
    pavucontrol
    teams-for-linux
    telegram-desktop
    vesktop
    vscode
    gnome-tweaks
    sqlitebrowser
    libreoffice-qt6-fresh
    tor-browser

    # CLI utils
    git
    neofetch
    curl
    ffmpeg
    yt-dlp
    tree
    file
    bc
    bottom
    brightnessctl
    cliphist
    ffmpeg
    ffmpegthumbnailer
    fzf
    git-graph
    grimblast
    htop
    hyprpicker
    ntfs3g
    mediainfo
    microfetch
    playerctl
    ripgrep
    showmethekey
    silicon
    udisks
    ueberzugpp
    unzip
    w3m
    wget
    wl-clipboard
    wtype
    yt-dlp
    zip
    flameshot
    direnv

    # GUI utils
    feh
    imv
    dmenu
    screenkey
    gromit-mpx

    # Sound
    pipewire
    pulseaudio
    pamixer

    # Coding stuff
    openjdk23
    nodejs
    # python2Full  # full 2.7 env
    # python3      # plain Python 3
    # (python3.withPackages (ps: with ps; [ requests ]))

    # Other
    bemoji
    nix-prefetch-scripts

    # Gnome extensions
    gnomeExtensions.clipboard-history
  ];
}