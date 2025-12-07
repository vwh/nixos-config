# Nix package manager configuration (flakes, GC, etc.).
# This module configures the Nix package manager with optimized settings
# for performance, storage management, and development workflow.

{ inputs, ... }:

{
  nix = {
    nixPath = [
      "nixpkgs=${inputs.nixpkgs}" # Point nixpkgs to our flake input
    ];

    # Disable NixOS channel to prevent conflicts with flakes
    channel.enable = false;

    extraOptions = ''
      warn-dirty = false
    '';

    settings = {
      # Enable modern Nix features
      experimental-features = [
        "nix-command" # Enable modern nix commands
        "flakes" # Enable flake support
      ];

      # Automatic store optimization
      auto-optimise-store = true;

      download-buffer-size = 262144000; # 250 MB (250 * 1024 * 1024)

      # Memory and stability improvements
      keep-outputs = true; # Keep build outputs for faster rebuilds
      keep-derivations = true; # Keep derivations for development
      sandbox = true; # Enable build sandboxing for security
      sandbox-fallback = false; # Don't fallback to non-sandboxed builds

      # Limit resource usage to prevent system overload
      max-substitution-jobs = 8; # Max parallel downloads
      http-connections = 25; # Max HTTP connections for downloads

      # Binary cache configuration
      substituters = [
        # high priority since it's almost always used
        "https://cache.nixos.org?priority=10"

        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://numtide.cachix.org"
      ];

      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];
    };

    # Garbage collection configuration
    gc = {
      automatic = true; # Enable automatic garbage collection
      persistent = true;
      dates = "weekly"; # Run weekly
      options = "--delete-older-than 7d";
    };
  };
}
