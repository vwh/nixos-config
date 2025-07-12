# Main Nix flake for system and home configurations.

{
  description = "NixOS + Home-Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      homeStateVersion = "25.05";
      user = "yazan";

      gitConfig = {
        name = "Yazan Alqasem";
        email = "vwhe@proton.me";
        gitKey = "0x5478BB36AC504E64";
      };

      hosts = [
        {
          hostname = "pc";
          stateVersion = "25.05";
        }

        {
          hostname = "thinkpad";
          stateVersion = "25.05";
        }
      ];

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      pkgsStable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };

      makeSystem =
        { hostname, stateVersion }:

        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit
              inputs
              stateVersion
              hostname
              user
              gitConfig
              pkgsStable
              ;
          };

          modules = [ ./hosts/${hostname}/configuration.nix ];
        };
    in
    {

      nixosConfigurations = nixpkgs.lib.foldl' (
        configs: host:
        configs
        // {
          "${host.hostname}" = makeSystem {
            inherit (host) hostname stateVersion;
          };
        }
      ) { } hosts;

      homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit
            inputs
            homeStateVersion
            user
            gitConfig
            pkgsStable
            ;
        };

        modules = [
          ./home-manager/home.nix
        ];
      };
    };
}
