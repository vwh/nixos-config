{
  description = "NixOS + Home-Manager flake";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    nixpkgs-stable = { url = "github:nixos/nixpkgs/nixos-25.05"; };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-stable
    , home-manager
    , ...
    }@inputs:
    let
      system = "x86_64-linux";
      homeStateVersion = "25.05";
      user = "yazan";
      hosts = [
        { hostname = "pc"; stateVersion = "25.05"; }
        { hostname = "thinkpad"; stateVersion = "25.05"; }
      ];

      # pkgs (unstable)
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      # pkgs (stable)
      pkgsStable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };

      makeSystem = { hostname, stateVersion }: nixpkgs.lib.nixosSystem {
        inherit system;
        
        specialArgs = { inherit inputs stateVersion hostname user pkgsStable; };
        modules     = [ ./hosts/${hostname}/configuration.nix ];
      };
    in {

    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs // {
        "${host.hostname}" = makeSystem {
          inherit (host) hostname stateVersion;
        };
      }) {} hosts;

    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs homeStateVersion user pkgsStable;
      };

      modules = [
        ./home-manager/home.nix
      ];
    };
    };
}
