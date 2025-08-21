# Nix package manager configuration (flakes, GC, etc.).

{ inputs, ... }:

{
  nix = {
    nixPath = [
      "nixpkgs=${inputs.nixpkgs}"
    ];

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = true;

      # Performance optimizations
      max-jobs = "auto";
      cores = 0; # Use all available cores

      # Storage optimization
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB

      # Memory and stability improvements for nixd
      keep-outputs = true;
      keep-derivations = true;
      sandbox = true;
      sandbox-fallback = false;

      # Limit memory usage to prevent crashes
      max-substitution-jobs = 8;
      http-connections = 25;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d --max-freed $((64 * 1024**3))";
    };
  };
}
