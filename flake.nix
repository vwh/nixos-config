{
  description = "NixOS + Home-Manager flake";

  inputs = {
    nixpkgs         = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    nixpkgs-stable  = { url = "github:nixos/nixpkgs/nixos-25.05"; };
    home-manager    = {
      url                    = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self
            , nixpkgs
            , nixpkgs-stable
            , home-manager
            , ... }@inputs:
  let
    system     = "x86_64-linux";

    # pkgs (unstable)
    pkgs       = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    # pkgs (stable)
    pkgsStable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  in
  {
    # 1) NixOS system
    nixosConfigurations.pc =
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit pkgsStable; };

        modules = [ ./nixos/configuration.nix ];
      };

    # 2) Home-Manager user
    homeConfigurations.yazan =
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit pkgsStable; };

        modules = [ ./home-manager/home.nix ];
      };
  };
}