{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["python-2.7.18.8" "electron-25.9.0"];
  };

  environment.systemPackages = with pkgs; [
    # Desktop apps
    audacity
    brave
    telegram-desktop
    alacritty
    obs-studio
    rofi
    wofi
    mpv
    discord
    gparted
    obsidian
    vscode

    # Coding stuff
    gcc
    nodejs
    python
    (python3.withPackages (ps: with ps; [ requests ]))

    # CLI utils
    git
    neofetch
    file
    tree
    wget
    git
    fastfetch
    htop
    nix-index
    unzip
    scrot
    ffmpeg
    light
    lux
    mediainfo
    ranger
    zram-generator
    cava
    zip
    ntfs3g
    yt-dlp
    brightnessctl
    swww
    openssl
    lazygit
    bluez
    bluez-tools

    # GUI utils
    feh
    imv
    dmenu
    screenkey
    gromit-mpx

    # Xorg stuff
    #xterm
    #xclip
    #xorg.xbacklight

    # Wayland stuff
    # xwayland
    # wl-clipboard
    # cliphist

    # WMs and stuff
    # herbstluftwm
    # hyprland
    # seatd
    # xdg-desktop-portal-hyprland
    # polybar
    # waybar

    # Sound
    pipewire
    pulseaudio
    pamixer

    # GPU stuff 
    # amdvlk
    # rocm-opencl-icd
    # glaxnimate

    # Screenshotting
    grim
    grimblast
    slurp
    flameshot
    swappy

    # Other
    home-manager
    # spice-vdagent
    # libsForQt5.qtstyleplugin-kvantum
    # libsForQt5.qt5ct
    # papirus-nord
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
  ];
}