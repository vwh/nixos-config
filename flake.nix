# Main Nix flake for system and home configurations.
# This flake provides a complete NixOS and Home Manager setup with declarative

{
  description = "Personal NixOS configuration";

  # External dependencies (inputs) - other flakes this configuration depends on
  inputs = {
    # Core package repositories
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Primary package source
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05"; # Stable package source

    # User environment management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Theme management
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Spotify customization
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secret management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Window manager
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; # Latest Hyprland with submodules

    # Web browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Flake outputs - what this flake provides to the outside world
  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      ...
    }@inputs:
    let
      # System configuration constants
      system = "x86_64-linux"; # Target system architecture
      homeStateVersion = "25.05"; # Home Manager state version
      user = "yazan"; # Primary username

      # Git configuration
      gitConfig = {
        name = "Yazan Alqasem";
        email = "vwhe@proton.me";
        signingKey = "0x5478BB36AC504E64"; # GPG key for signing commits
      };

      # Host configurations - defines available systems
      hosts = [
        {
          hostname = "pc"; # Desktop workstation
          stateVersion = "25.05"; # NixOS state version
        }

        {
          hostname = "thinkpad"; # Laptop system
          stateVersion = "25.05"; # NixOS state version
        }
      ];

      # Package sets with configurations
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true; # Allow proprietary packages
          allowBroken = false; # Don't allow broken packages
          allowInsecure = false; # Don't allow insecure packages
          allowUnsupportedSystem = false; # Don't allow unsupported systems
        };
      };

      pkgsStable = import nixpkgs-stable {
        inherit system;
        config = {
          allowUnfree = true;
          allowBroken = false;
          allowInsecure = false;
          allowUnsupportedSystem = false;
        };
      };

      # Function to create a complete NixOS system configuration
      makeSystem =
        { hostname, stateVersion }:

        nixpkgs.lib.nixosSystem {
          inherit system;

          # Arguments passed to all modules
          specialArgs = {
            inherit
              inputs # All flake inputs
              stateVersion # NixOS state version
              hostname # System hostname
              user # Primary user
              gitConfig # Git configuration
              pkgsStable # Stable package set
              ;
          };

          # Modules to include in this system
          modules = [ ./hosts/${hostname}/configuration.nix ];
        };
    in
    {
      # Generate NixOS system configurations for each host
      nixosConfigurations = nixpkgs.lib.foldl' (
        configs: host:
        configs // { "${host.hostname}" = makeSystem { inherit (host) hostname stateVersion; }; }
      ) { } hosts;

      # Home Manager configuration for user
      homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Arguments passed to home-manager modules
        extraSpecialArgs = {
          inherit
            inputs # All flake inputs
            homeStateVersion # Home Manager state version
            user # Username
            gitConfig # Git configuration
            pkgsStable # Stable package set
            ;
        };

        # Home Manager modules to include
        modules = [ ./home-manager/home.nix ];
      };
    };
}
