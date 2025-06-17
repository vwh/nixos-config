{
  description = "NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };

  in 
  {
    nixosConfigurations = {
      pc = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system; };
        modules = [ ./nixos/configuration.nix ];
      };
    };
  };
}
